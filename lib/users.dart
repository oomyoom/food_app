class Account {
  final String email, password;

  Account({required this.email, required this.password});
}

class Profile {
  final Account account;
  final String username, firstname, lastname, birthday;
  Profile(
      {required this.account,
      required this.username,
      required this.firstname,
      required this.lastname,
      required this.birthday});
}

class User {
  final Account account;
  final Profile profile;
  User({required this.account, required this.profile});
}
