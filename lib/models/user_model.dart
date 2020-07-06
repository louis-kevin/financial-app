class UserModel {
  int id;
  String name;
  String email;

  UserModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
  }

  Map<String, dynamic> toJson() {
    var data = {'id': this.id, 'name': this.name, 'email': this.email};

    return data;
  }
}
