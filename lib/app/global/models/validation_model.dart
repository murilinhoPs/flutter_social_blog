class ValidationModel {
  String message;
  ValidationErrors validationErrors;

  ValidationModel({this.message, this.validationErrors});

  ValidationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    validationErrors = json['validationErrors'] != null
        ? new ValidationErrors.fromJson(json['validationErrors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.validationErrors != null) {
      data['validationErrors'] = this.validationErrors.toJson();
    }
    return data;
  }
}

class ValidationErrors {
  List<String> username;
  List<String> email;
  List<String> password;
  List<String> imagePath;

  ValidationErrors({this.username, this.email, this.password, this.imagePath});

  ValidationErrors.fromJson(Map<String, dynamic> json) {
    username = json['username'].cast<String>();
    email = json['email'].cast<String>();
    password = json['password'].cast<String>();
    imagePath = json['image.path'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image.path'] = this.imagePath;
    return data;
  }
}
