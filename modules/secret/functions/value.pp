function secret::value(String $name) >> String {
  regsubst(file("secret/$name"), /\n\z/, '')
}
