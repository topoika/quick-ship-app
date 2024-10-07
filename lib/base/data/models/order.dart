part of "../data.dart";

class Order {
  int? id;
  Package? package;
  Trip? trip;
  Review? review;
  Payment? payment;
  String? status;
  String? createdAt;
  Order({
    this.id,
    this.package,
    this.trip,
    this.review,
    this.payment,
    this.status,
    this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as int : null,
      package: map['package'] != null
          ? Package.fromMap(map['package'] as Map<String, dynamic>)
          : null,
      trip: map['trip'] != null
          ? Trip.fromMap(map['trip'] as Map<String, dynamic>)
          : null,
      review: map['review'] != null
          ? Review.fromMap(map['review'] as Map<String, dynamic>)
          : null,
      payment: map['payment'] != null
          ? Payment.fromMap(map['payment'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}

class Review {
  int? id;
  String? review;
  int? rating;
  double? tipAmount;
  String? createdAt;

  Review({this.id, this.review, this.rating, this.tipAmount, this.createdAt});

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] != null ? map['id'] as int : null,
      review: map['review'] != null ? map['review'] as String : null,
      rating: map['rating'] != null ? map['rating'] as int : null,
      tipAmount: map['tipAmount'] != null
          ? double.parse(map['tipAmount'].toString())
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}

class Payment {
  int? id;
  double? amount;
  int? shipperId;
  int? postManId;
  String? mpesaReceiptNumber;
  String? referenceNumber;
  String? mpesaNumber;
  String? status;
  String? createdAt;

  Payment({
    this.id,
    this.amount,
    this.shipperId,
    this.postManId,
    this.mpesaReceiptNumber,
    this.referenceNumber,
    this.mpesaNumber,
    this.status,
    this.createdAt,
  });

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] != null ? map['id'] as int : null,
      amount:
          map['amount'] != null ? double.parse(map['amount'].toString()) : null,
      shipperId: map['shipperId'] != null ? map['shipperId'] as int : null,
      postManId: map['postManId'] != null ? map['postManId'] as int : null,
      mpesaReceiptNumber: map['mpesaReceiptNumber'] != null
          ? map['mpesaReceiptNumber'] as String
          : null,
      referenceNumber: map['referenceNumber'] != null
          ? map['referenceNumber'] as String
          : null,
      mpesaNumber:
          map['mpesaNumber'] != null ? map['mpesaNumber'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
