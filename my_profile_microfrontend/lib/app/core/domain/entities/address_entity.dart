class AddressEntity {
  final String? streetType;
  final String? street;
  final String? number;
  final String? complement;
  final String? district;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  AddressEntity({
    this.streetType,
    this.street,
    this.number,
    this.complement,
    this.district,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
      streetType: json['tipo_logradouro'],
      street: json['logradouro'],
      number: json['address_number'],
      complement: json['complement'],
      district: json['neighborhood'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['cep'],
    );
  }
}
