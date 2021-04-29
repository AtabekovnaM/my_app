class User {
  String uid = "";
  String fullname = "";
  String email = "";
  String password = "";

  User({this.fullname, this.email, this.password});
  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        fullname = json['fullname'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'fullname': fullname,
    'email': email,
    'password': password,
  };

  @override
  bool operator ==(other) {
    return (other is User) && other.uid == uid;
  }
}