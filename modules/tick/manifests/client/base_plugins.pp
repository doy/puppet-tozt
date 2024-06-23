class tick::client::base_plugins {
  tick::client::plugin {
    "disk":
      opts => {
        ignore_fs => [
          "tmpfs",
          "devtmpfs",
          "devfs",
          "iso9660",
          "overlay",
          "aufs",
          "squashfs"
        ],
      };
    "net":
      opts => {
        ignore_protocol_stats => true,
      };
    [
      "cpu",
      "diskio",
      "internal",
      "kernel",
      "mem",
      "netstat",
      "ntpq",
      "processes",
      "swap",
      "system",
    ]:
  }

  class {
    [
      "tick::client::plugin::borg",
      "tick::client::plugin::godwrap",
      "tick::client::plugin::pacman",
      "tick::client::plugin::restic",
    ]:
  }
}
