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
  String? image;

  int? reviewCount;
  double? averageRating;

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
    this.image,
    this.reviewCount,
    this.averageRating,
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

  Map<String, dynamic> toChatMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'signInMethod': signInMethod,
      'verified': verified,
    };
  }

  // toUpdateMap
  Map<String, dynamic> toUpdateMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'idNumber': idNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      image: map['image'] != null ? getImageUrl(map['image']) : null,
      idNumber: map['idNumber'] != null ? map['idNumber'] as String : null,
      succesScore:
          map['succesScore'] != null ? map['succesScore'] as double : null,
      role: map['role'] != null ? map['role'] as String : null,
      verificationFront: map['verificationFront'] != null
          ? mediaUrl + map['verificationFront']
          : null,
      verificationBack: map['verificationBack'] != null
          ? mediaUrl + map['verificationBack']
          : null,
      signInMethod:
          map['signInMethod'] != null ? map['signInMethod'] as String : null,
      verified: map['verified'] != null ? map['verified'] as bool : null,
      signInMethodVerified: map['signInMethodVerified'] != null
          ? map['signInMethodVerified'] as bool
          : null,
      isBlocked: map['isBlocked'] != null ? map['isBlocked'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      reviewCount:
          map['reviewCount'] != null ? map['reviewCount'] as int : null,
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'].toString())
          : 0.0,
    );
  }
}

String getImageUrl(String? image) {
  if (image == null) {
    return "";
  }
  // if image starts with http, return image
  if (image.startsWith('http')) {
    return image;
  }
  // else return mediaUrl + image
  return mediaUrl + image;
}

class UserWallet {
  int? id;
  double? availableForWithdrawal;
  double? earningsForMonth;
  double? successScore;
  double? earningsAllTime;
  int? completedOrders;
  int? activeOrders;
  UserWallet({
    this.id,
    this.availableForWithdrawal,
    this.earningsForMonth,
    this.successScore,
    this.earningsAllTime,
    this.completedOrders,
    this.activeOrders,
  });

  factory UserWallet.fromMap(Map<String, dynamic> map) {
    return UserWallet(
      id: map['id'] != null ? map['id'] as int : null,
      availableForWithdrawal: map['availableForWithdrawal'] != null
          ? double.parse(map['availableForWithdrawal'].toString())
          : null,
      earningsForMonth: map['earningsAllTime'] != null
          ? double.parse(map['earningsAllTime'].toString())
          : null,
      successScore: map['successScore'] != null
          ? double.parse(map['successScore'].toString())
          : null,
      earningsAllTime: map['earningsAllTime'] != null
          ? double.parse(map['earningsAllTime'].toString())
          : null,
      completedOrders:
          map['completedOrders'] != null ? map['completedOrders'] as int : null,
      activeOrders:
          map['activeOrders'] != null ? map['activeOrders'] as int : null,
    );
  }
}
