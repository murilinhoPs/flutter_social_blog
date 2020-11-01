import 'package:challenge_bt_app/app/global/models/user_model.dart';

class AllPostsModel {
  PostFromAll post;

  AllPostsModel({this.post});

  AllPostsModel.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new PostFromAll.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}

class PostFromAll {
  int id;
  String content;
  UserFromPost user;

  PostFromAll({this.id, this.content, this.user});

  PostFromAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user = json['user'] != null ? new UserFromPost.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class UserFromPost {
  int id;
  String username;
  String email;
  ImagePost image;

  UserFromPost({this.id, this.username, this.email, this.image});

  UserFromPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    image = json['image'] != null ? new ImagePost.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    return data;
  }
}

class ImagePost {
  int id;
  String path;

  ImagePost({this.id, this.path});

  ImagePost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    return data;
  }
}
