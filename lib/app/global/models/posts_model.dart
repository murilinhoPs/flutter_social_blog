class PostModel {
  PostBase post;

  PostModel({this.post});

  PostModel.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new PostBase.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}

class PostBase {
  int id;
  String content;

  PostBase({this.id, this.content});

  PostBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post'] = this.content;
    return data;
  }
}
