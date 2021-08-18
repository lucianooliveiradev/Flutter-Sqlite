class Address {
  String? publicPlace;
  int? number;
  String? cep;
  String? state;
  String? city;
  String? complement;

  Address(
      {this.publicPlace,
      this.number,
      this.cep,
      this.state,
      this.city,
      this.complement});

  Address.fromJson(Map<String, dynamic> json) {
    publicPlace = json['publicPlace'];
    number = json['number'];
    cep = json['cep'];
    state = json['state'];
    city = json['city'];
    complement = json['complement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicPlace'] = this.publicPlace;
    data['number'] = this.number;
    data['cep'] = this.cep;
    data['state'] = this.state;
    data['city'] = this.city;
    data['complement'] = this.complement;
    return data;
  }
}
