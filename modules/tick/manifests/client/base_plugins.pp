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
    [
      "cpu",
      "diskio",
      "kernel",
      "mem",
      "processes",
      "swap",
      "system",
    ]:
  }
}
