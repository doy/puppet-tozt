from pathlib import Path
from typing import Optional

import pulumi
import pulumi_digitalocean as do
import pulumi_command as command

from .ssh import SshKey


class Instance(pulumi.ComponentResource):
    def __init__(
        self,
        name: str,
        region: str,
        size: str,
        dns_name: str,
        reserved_ip: Optional[str] = None,
        volume_name: Optional[str] = None,
        opts: Optional[pulumi.ResourceOptions] = None,
    ):
        self.name = name
        self.dns_name = dns_name
        self.reserved_ip = reserved_ip

        super().__init__(
            f"{pulumi.get_project()}:instance:Instance/{name}", name, None, opts
        )

        ssh_key = SshKey(
            f"{self.name}-ssh-keypair",
            opts=pulumi.ResourceOptions(parent=self),
        )
        ssh = do.SshKey(
            self.name,
            public_key=ssh_key.public_key,
            name=f"{pulumi.get_project()}-{pulumi.get_stack()}-{self.name}",
            opts=pulumi.ResourceOptions(parent=self),
        )

        volumes = []
        if volume_name is not None:
            volume = do.get_volume_output(
                name=volume_name,
                region=region,
                opts=pulumi.InvokeOptions(parent=self),
            )
            volumes.append(volume.id)
        self.instance = do.Droplet(
            self.name,
            name=dns_name,
            image="debian-12-x64",
            region=region,
            size=size,
            ssh_keys=[ssh.id],
            volume_ids=volumes,
            opts=pulumi.ResourceOptions(parent=self),
        )

        if reserved_ip is not None:
            self.ip_assignment = do.ReservedIpAssignment(
                self.name,
                ip_address=reserved_ip,
                droplet_id=self.instance.id.apply(lambda id: int(id)),
                opts=pulumi.ResourceOptions(parent=self),
            )

        connection = command.remote.ConnectionArgs(
            host=self.instance.ipv4_address,
            private_key=ssh_key.private_key,
            user="root",
            dial_error_limit=100,
        )
        bootstrap_debian_file = command.remote.CopyToRemote(
            f"{self.name}-bootstrap_debian",
            connection=connection,
            source=pulumi.FileAsset("bootstrap/debian"),
            remote_path="/tmp/bootstrap",
            opts=pulumi.ResourceOptions(parent=self),
        )
        bootstrap_debian = command.remote.Command(
            f"{self.name}-bootstrap_debian",
            connection=connection,
            create="sh /tmp/bootstrap",
            opts=pulumi.ResourceOptions(
                parent=self, depends_on=[bootstrap_debian_file]
            ),
        )
        sleep = command.local.Command(
            f"{self.name}-sleep",
            create="sleep 30",
            opts=pulumi.ResourceOptions(parent=self, depends_on=[bootstrap_debian]),
        )
        make_secrets_dir = command.remote.Command(
            f"{self.name}-make_secrets_dir",
            connection=connection,
            create="mkdir /tmp/secrets",
            opts=pulumi.ResourceOptions(parent=self, depends_on=[sleep]),
        )
        bootstrap_arch_file = command.remote.CopyToRemote(
            f"{self.name}-bootstrap_arch",
            connection=connection,
            source=pulumi.FileAsset("bootstrap/arch"),
            remote_path="/tmp/bootstrap",
            opts=pulumi.ResourceOptions(parent=self, depends_on=[sleep]),
        )
        secret_files = []
        for file in Path(f"/mnt/puppet/{name}").glob("*"):
            secret_files.append(
                command.remote.CopyToRemote(
                    f"{self.name}-secret-{file.name}",
                    connection=connection,
                    source=pulumi.FileAsset(str(file)),
                    remote_path=f"/tmp/secrets/{file.name}",
                    opts=pulumi.ResourceOptions(
                        parent=self, depends_on=[make_secrets_dir]
                    ),
                )
            )
        command.remote.Command(
            f"{self.name}-bootstrap_arch",
            connection=connection,
            create="sh /tmp/bootstrap",
            opts=pulumi.ResourceOptions(
                parent=self,
                depends_on=[bootstrap_arch_file, *secret_files],
            ),
        )

        self.register_outputs(
            {
                "dns_name": dns_name,
                "ip_address": self.instance.ipv4_address,
            }
        )
