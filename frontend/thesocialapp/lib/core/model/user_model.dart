import 'dart:convert';

class User {
  int id;
  String username;
  String useremail;
  String userpassword;
  String userimage;
  User({
    required this.id,
    required this.username,
    required this.useremail,
    required this.userpassword,
    required this.userimage,
  });

  User copyWith({
    int? id,
    String? username,
    String? useremail,
    String? userpassword,
    String? userimage,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      useremail: useremail ?? this.useremail,
      userpassword: userpassword ?? this.userpassword,
      userimage: userimage ?? this.userimage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'useremail': useremail,
      'userpassword': userpassword,
      'userimage': userimage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      useremail: map['useremail'] ?? '',
      userpassword: map['userpassword'] ?? '',
      userimage: map['userimage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, useremail: $useremail, userpassword: $userpassword, userimage: $userimage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.username == username &&
        other.useremail == useremail &&
        other.userpassword == userpassword &&
        other.userimage == userimage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        useremail.hashCode ^
        userpassword.hashCode ^
        userimage.hashCode;
  }
}
