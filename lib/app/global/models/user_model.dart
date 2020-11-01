import 'package:challenge_bt_app/app/global/models/posts_model.dart';

class UserModel {
  int id;
  String username;
  String email;
  Image image;
  List<PostModel> posts;
  Bio bio;

  UserModel({this.id, this.username, this.email, this.image, this.posts, this.bio});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    if (json['posts'] != null) {
      posts = new List<PostModel>();
      json['posts'].forEach((v) {
        posts.add(new PostModel.fromJson(v));
      });
    }
    bio = json['bio'] != null ? new Bio.fromJson(json['bio']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    if (this.bio != null) {
      data['bio'] = this.bio.toJson();
    }
    return data;
  }
}

class Image {
  int id;
  String url;

  Image({this.id, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}

class Bio {
  int id;
  String content;

  Bio({this.id, this.content});

  Bio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}
