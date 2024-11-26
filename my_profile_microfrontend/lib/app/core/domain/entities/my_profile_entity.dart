import 'package:my_profile_microfrontend/app/core/domain/entities/address_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/documents_entity.dart';

class MyProfileEntity {
  final String firstName;
  final String lastName;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? docNumber;
  final String? healthCarePlan;
  final String? referenceHospital;
  final String? birthdate;
  final String? description;
  final String? avatarUrl;
  final double? weight;
  final double? height;
  final String? foot;
  final String? gender;
  final int? studentId;

  final AddressEntity? address;
  final DocumentsEntity? documents;

  MyProfileEntity({
    required this.firstName,
    required this.lastName,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.docNumber,
    this.birthdate,
    this.description,
    this.healthCarePlan,
    this.referenceHospital,
    this.avatarUrl,
    this.weight,
    this.height,
    this.foot,
    this.gender,
    this.address,
    this.documents,
    this.studentId,
  });

  factory MyProfileEntity.fromJson(Map<String, dynamic> json) {
    return MyProfileEntity(
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullName: parseEmptyValue(json['formatted_name']),
      phoneNumber: parseEmptyValue(json['phone_number']),
      email: parseEmptyValue(json['email']),
      docNumber: parseEmptyValue(json['cpf']),
      birthdate: parseEmptyValue(json['birthdate']),
      description: parseEmptyValue(json['description']),
      healthCarePlan: parseEmptyValue(json['healthcare_plan']),
      referenceHospital: parseEmptyValue(json['reference_hospital']),
      avatarUrl: parseEmptyValue(json['picture']),
      weight: json['weight'],
      height: json['height'],
      foot: parseEmptyValue(json['foot']),
      gender: parseEmptyValue(json['gender']),
      address: json['address'] != null
          ? AddressEntity.fromJson(json['address'])
          : null,
      documents: DocumentsEntity.fromJson(json),
      // ignore: prefer_if_null_operators
      studentId: json['student_id'] != null ? json['student_id'] : null,
    );
  }

  String? get formattedHeight {
    if (height != null) {
      return height!.toStringAsFixed(2).replaceAll('.', ',');
    }
    return null;
  }

  String? get formattedWeight {
    if (weight != null) {
      return weight!.toStringAsFixed(1).replaceAll('.', ',');
    }
    return null;
  }

  String? get formattedPhoneNumber {
    if (phoneNumber != null && phoneNumber?.length == 11) {
      return '${phoneNumber!.substring(0, 2)} ${phoneNumber!.substring(2, 7)}-${phoneNumber!.substring(7, 11)}';
    }
    return phoneNumber;
  }
}

String? parseEmptyValue(String? value) =>
    value != null && value.isNotEmpty ? value : null;
