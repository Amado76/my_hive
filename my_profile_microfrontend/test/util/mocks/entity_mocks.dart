import 'package:faker/faker.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/address_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/documents_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/file_document_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';

DocumentsEntity documentEntityMock = DocumentsEntity(
  cpf: faker.guid.guid(),
  nif: faker.guid.guid(),
  nis: faker.guid.guid(),
  birthCertificate: faker.guid.guid(),
);

FileDocumentEntity fileDocumentEntityMock = FileDocumentEntity(
  id: faker.randomGenerator.integer(999),
  description: faker.lorem.word(),
  observation: faker.lorem.sentence(),
  fileUrl: faker.image.loremPicsum(),
);

AddressEntity addressEntityMock = AddressEntity(
  streetType: faker.address.streetSuffix(),
  street: faker.address.streetAddress(),
  number: faker.randomGenerator.integer(999).toString(),
  complement: faker.lorem.word(),
  district: faker.address.neighborhood(),
  city: faker.address.city(),
  state: faker.address.stateAbbreviation(),
  postalCode: faker.address.zipCode(),
  country: faker.address.country(),
);

MyProfileEntity myProfileEntityMock = MyProfileEntity(
  firstName: faker.person.firstName(),
  lastName: faker.person.lastName(),
  fullName: faker.person.name(),
  phoneNumber: faker.phoneNumber.us(),
  email: faker.internet.email(),
  docNumber: faker.guid.guid(),
  birthdate: faker.date.dateTime().toString(),
  description: faker.lorem.sentence(),
  avatarUrl: faker.image.loremPicsum(),
  weight: faker.randomGenerator.decimal(scale: 2),
  height: faker.randomGenerator.decimal(scale: 2),
  foot: faker.lorem.word(),
  gender: faker.lorem.word(),
  documents: documentEntityMock,
  address: addressEntityMock,
);
