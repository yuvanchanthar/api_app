class Company {
  int? id;
  String? logo;
  String? name;
  String? phone;
  String? address;

  Company({
    this.id,
    this.logo,
    this.name,
    this.phone,
    this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      logo: json['logo'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      
      "name": name,
      "logo": logo,
      "phone": phone,
      "address": address,
    };
  }
}
