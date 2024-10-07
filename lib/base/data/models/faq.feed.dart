// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../data.dart";

class FAQ {
  int? id;
  String? question;
  String? description;

  String? createdAt;

  FAQ({
    this.id,
    this.question,
    this.description,
    this.createdAt,
  });

  factory FAQ.fromMap(Map<String, dynamic> map) {
    return FAQ(
      id: map['id'] != null ? map['id'] as int : null,
      question: map['question'] != null ? map['question'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}

class Feed {
  int? id;
  String? title;
  String? body;
  String? image;
  User? writter;
  String? createdAt;

  Feed({
    this.id,
    this.title,
    this.body,
    this.image,
    this.writter,
    this.createdAt,
  });

  factory Feed.fromMap(Map<String, dynamic> map) {
    return Feed(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      writter: map['writter'] != null
          ? User.fromMap(map['writter'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
