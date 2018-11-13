function secret::value(String $name) >> String {
  chomp(file("secret/$name"))
}
