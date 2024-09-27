part of "../data.dart";

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? idNumber;
  double? succesScore;
  String? role;
  String? verificationFront;
  String? verificationBack;
  String? signInMethod;
  bool? verified;
  bool? signInMethodVerified;
  bool? isBlocked;
  String? createdAt;
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.idNumber,
    this.succesScore,
    this.role,
    this.verificationFront,
    this.verificationBack,
    this.signInMethod,
    this.verified,
    this.signInMethodVerified,
    this.isBlocked,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'idNumber': idNumber,
      'succesScore': succesScore,
      'role': role,
      'verificationFront': verificationFront,
      'verificationBack': verificationBack,
      'signInMethod': signInMethod,
      'verified': verified,
      'signInMethodVerified': signInMethodVerified,
      'isBlocked': isBlocked,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      idNumber: map['idNumber'] != null ? map['idNumber'] as String : null,
      succesScore:
          map['succesScore'] != null ? map['succesScore'] as double : null,
      role: map['role'] != null ? map['role'] as String : null,
      verificationFront: map['verificationFront'] != null
          ? map['verificationFront'] as String
          : null,
      verificationBack: map['verificationBack'] != null
          ? map['verificationBack'] as String
          : null,
      signInMethod:
          map['signInMethod'] != null ? map['signInMethod'] as String : null,
      verified: map['verified'] != null ? map['verified'] as bool : null,
      signInMethodVerified: map['signInMethodVerified'] != null
          ? map['signInMethodVerified'] as bool
          : null,
      isBlocked: map['isBlocked'] != null ? map['isBlocked'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
