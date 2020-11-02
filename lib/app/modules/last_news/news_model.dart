class NewsModel {
  UserNews user;
  Message message;

  NewsModel({this.user, this.message});

  NewsModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserNews.fromJson(json['user']) : null;
    message = json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class UserNews {
  String name;
  String profilePicture;

  UserNews({this.name, this.profilePicture});

  UserNews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}

class Message {
  String content;
  String createdAt;

  Message({this.content, this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    return data;
  }
}
