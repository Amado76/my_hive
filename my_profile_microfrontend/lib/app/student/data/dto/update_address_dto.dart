import 'package:my_profile_microfrontend/app/student/domain/dto/student_dto.dart';

class UpdateAddressDto extends StudentDto {
  static const pageId = 3;

  final String? streetType;
  final String? street;
  final String? number;
  final String? complement;
  final String? district;
  final String? postalCode;
  final String? city;
  final String? state;

  UpdateAddressDto({
    required this.streetType,
    required this.street,
    required this.number,
    required this.complement,
    required this.district,
    required this.postalCode,
    required this.city,
    required this.state,
  });

  @override
  Map<String, dynamic> toJson() {
    var jsonData = {
      'page_id': pageId,
      'tipo_logradouro': streetType,
      'logradouro': street,
      'address_number': number,
      'complement': complement,
      'neighborhood': district,
      'cep': postalCode,
      'city': city,
      'state': state,
    };

    jsonData.removeWhere((_, value) => value == null);

    return jsonData;
  }
}
