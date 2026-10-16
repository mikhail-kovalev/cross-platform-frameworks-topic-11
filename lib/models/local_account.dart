class LocalAccount {
  String name = '';
  String email = '';
  String _password = '';
  bool signedIn = false;

  bool get registered => email.isNotEmpty;

  void register(String fullName, String address, String password) {
    name = fullName.trim();
    email = address.trim();
    _password = password;
    signedIn = true;
  }

  bool signIn(String address, String password) {
    signedIn =
        registered &&
        email.toLowerCase() == address.trim().toLowerCase() &&
        _password == password;
    return signedIn;
  }

  void update(String fullName, String address, String password) {
    register(fullName, address, password);
  }
}
