import 'package:faker/faker.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_access_data_dto.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_address_dto.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_documents_dto.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_personal_data_dto.dart';

import 'entity_mocks.dart';

UpdateAccessDataDto updateAccessDataDtoMock = UpdateAccessDataDto(
  email: faker.internet.email(),
  phoneNumber: faker.phoneNumber.us(),
  newPassword: faker.internet.password(),
  newPasswordConfirmation: faker.internet.password(),
);

UpdateAddressDto updateAddressDtoMock = UpdateAddressDto(
  streetType: faker.address.streetSuffix(),
  street: faker.address.streetAddress(),
  number: faker.randomGenerator.integer(999).toString(),
  complement: faker.lorem.word(),
  district: faker.address.neighborhood(),
  postalCode: faker.address.zipCode(),
  city: faker.address.city(),
  state: faker.address.stateAbbreviation(),
);

UpdateDocumentsDto updateDocumentsDtoMock = UpdateDocumentsDto(
  cpf: faker.guid.guid(),
  rg: faker.guid.guid(),
  nis: faker.guid.guid(),
  nif: faker.guid.guid(),
  birthCertificate: faker.guid.guid(),
  filesToDelete: [faker.randomGenerator.integer(999)],
  files: [fileDocumentEntityMock],
);

UpdatePersonalDataDto updatePersonalDataDtoMock = UpdatePersonalDataDto(
  firstName: faker.person.firstName(),
  lastName: faker.person.lastName(),
  birthdate: faker.date.dateTime().toString(),
  gender: faker.lorem.word(),
  weight: faker.randomGenerator.decimal(scale: 2),
  height: faker.randomGenerator.decimal(scale: 2),
  dominantSide: faker.lorem.word(),
  healthCarePlan: faker.lorem.word(),
  referenceHospital: faker.company.name(),
  avatar: faker.image.loremPicsum(),
);
