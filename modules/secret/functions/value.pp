function secret::value(String $name) >> String {
  file("secret/$name")
}
