import sys

import pulumi

sys.path.append(".")

from tozt.instance import Instance  # noqa: E402

tozt = Instance(
    "tozt",
    region="nyc3",
    size="s-1vcpu-1gb",
    dns_name="tozt.net",
    reserved_ip="138.197.58.11",
    volume_name="tozt-persistent",
)

pulumi.export(
    "tozt",
    {
        "ip": tozt.instance.ipv4_address,
        "domain": tozt.dns_name,
        "reserved_ip": tozt.reserved_ip,
    },
)
