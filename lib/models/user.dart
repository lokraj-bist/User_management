class User {
  final int id;
  final String name;
  final String username;
  final String email;
  bool isFav;

  User({required this.id,
    required this.name,
    required this.username,
    required this.email, required this.isFav});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'], isFav: json['isFav']??false,
    );
  }
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({required this.id,
    required this.userId,
    required this.title,
    required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class Comment {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  Comment({required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
