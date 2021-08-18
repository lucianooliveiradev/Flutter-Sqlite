class User {
  int? id;
  String? name;
  String? lastName;
  // String? picture;
  // String? address;
  bool? isActive;

  User({
    this.id,
    this.name,
    this.lastName,
    // this.picture,
    // this.address,
    this.isActive,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    // picture = json['picture'];
    // address = json['address'];
    isActive = json['isActive'] == 0 ? false : true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    // data['picture'] = this.picture;
    // data['address'] = this.address;
    data['isActive'] = this.isActive == true ? 1 : 0;
    return data;
  }
}
