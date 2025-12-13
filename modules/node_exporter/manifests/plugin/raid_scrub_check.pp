class node_exporter::plugin::raid_scrub_check {
  node_exporter::plugin { "raid_scrub_check":
    source => "puppet:///modules/node_exporter/plugins/raid_scrub_check";
  }
}
