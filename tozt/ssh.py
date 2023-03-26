import binascii
import os
import subprocess
import tempfile
from typing import Any, Optional, Tuple

import pulumi


class SshKeyProvider(pulumi.dynamic.ResourceProvider):
    def create(self, inputs: Any):
        (private_key, public_key) = ssh_keygen()
        return pulumi.dynamic.CreateResult(
            id_=str(binascii.b2a_hex(os.urandom(16))),
            outs={"private_key": private_key, "public_key": public_key},
        )


class SshKey(pulumi.dynamic.Resource):
    private_key: pulumi.Output[str]
    public_key: pulumi.Output[str]

    def __init__(
        self, name: str, opts: Optional[pulumi.ResourceOptions] = None
    ):
        super().__init__(
            SshKeyProvider(),
            name,
            {"private_key": None, "public_key": None},
            opts,
        )


def ssh_keygen() -> Tuple[str, str]:
    with tempfile.TemporaryDirectory() as dir:
        key = f"{dir}/id_rsa"
        close = []
        try:
            (priv_r, priv_w) = os.pipe()
            close.extend([priv_r, priv_w])
            (pub_r, pub_w) = os.pipe()
            close.extend([pub_r, pub_w])
            (yes_r, yes_w) = os.pipe()
            close.extend([yes_r, yes_w])
            os.symlink(f"/proc/self/fd/{priv_w}", f"{key}")
            os.symlink(f"/proc/self/fd/{pub_w}", f"{key}.pub")
            os.write(yes_w, b"y\n")
            os.close(yes_w)
            subprocess.check_call(
                ["ssh-keygen", "-q", "-N", "", "-f", key],
                pass_fds=(pub_w, priv_w),
                stdin=yes_r,
                stdout=subprocess.DEVNULL,
            )
            os.close(priv_w)
            os.close(pub_w)
            os.close(yes_r)
            with open(priv_r) as f:
                privkey = f.read()
            with open(pub_r) as f:
                pubkey = f.read()
        except Exception:
            for fd in close:
                try:
                    os.close(fd)
                except Exception:
                    pass
            raise
        return (privkey, pubkey)
