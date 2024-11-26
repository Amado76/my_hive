import 'package:faker/faker.dart';

Map<String, dynamic> getProfileDataMock = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": {
    "first_name": faker.person.firstName(),
    "last_name": faker.person.lastName(),
    "formatted_name": faker.person.name(),
    "phone_number": '11999999999',
    "email": faker.internet.email(),
    "cpf": faker.guid.guid(),
    "nif": faker.guid.guid(),
    "nis": faker.guid.guid(),
    "birth_ceritficate": faker.guid.guid(),
    "healthcare_plan": faker.lorem.word(),
    "reference_hospital": faker.company.name(),
    "birthdate": faker.date.dateTime().toString(),
    "description": faker.lorem.sentence(),
    "picture_url": faker.image.loremPicsum(),
    "height": 1.70,
    "weight": 70.5,
    "foot": faker.lorem.word(),
    "gender": faker.lorem.word(),
    "address": {
      "tipo_logradouro": faker.address.streetSuffix(),
      "logradouro": faker.address.streetAddress(),
      "address_number": faker.randomGenerator.integer(999).toString(),
      "complement": faker.lorem.word(),
      "neighborhood": faker.address.neighborhood(),
      "city": faker.address.city(),
      "state": faker.address.stateAbbreviation(),
      "cep": faker.address.zipCode(),
      "country": faker.address.country(),
    },
    "documents": [
      {
        "id": faker.randomGenerator.integer(999),
        "description": faker.lorem.word(),
        "observations": faker.lorem.sentence(),
        "file_url": faker.image.loremPicsum(),
      }
    ]
  }
};

Map<String, dynamic> updateProfileMock = {
  "status": "1",
  "msg": "Usuario editado com sucesso",
  "token": faker.guid.guid(),
};

Map<String, dynamic> viaCepMock = {
  "cep": faker.address.zipCode(),
  "logradouro": faker.address.streetName(),
  "complemento": faker.lorem.word(),
  "bairro": faker.address.neighborhood(),
  "localidade": faker.address.city(),
  "uf": faker.address.stateAbbreviation(),
  "ibge": faker.guid.guid(),
  "gia": faker.guid.guid(),
  "ddd": faker.randomGenerator.integer(2).toString(),
  "siafi": faker.guid.guid(),
};
