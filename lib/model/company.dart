class Company {
  final int? id;
  final String? logo;
  final String name;
  final String phone;
  final String address;

  Company({
    this.id,
    this.logo,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      logo: json['logo'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if(id != null)'id' : id,
      if(logo != null)'logo':logo,
      "name": name,
     
      "phone": phone,
      "address": address,
    };
  }
  Company copyWith({
    int? id,
    String? logo,
    String? name,
    String? phone,
    String? address,
  }){
    return Company(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      name: name ?? this.name,
       phone: phone ?? this.phone, 
       address: address  ?? this.address);
  }

}
