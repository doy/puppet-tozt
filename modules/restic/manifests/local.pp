class restic::local($extra_paths = []) {
  include restic
  
  class { 'restic::instance':
    repo => "/media/persistent/restic/${facts['networking']['hostname']}",
    extra_paths => $extra_paths;
  }
}
