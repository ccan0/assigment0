class CommentsModel {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  CommentsModel({this.postId, this.id, this.name, this.email, this.body});

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  Map toJson() {
    return {'postId': postId, 'id': id, 'name': name, 'email': email, 'body': body};
  }
}
