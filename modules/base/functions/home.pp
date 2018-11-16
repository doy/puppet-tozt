function base::home(String $user) >> String {
  $user ? {
    'root' => '/root',
    default => "/home/$user",
  }
}
