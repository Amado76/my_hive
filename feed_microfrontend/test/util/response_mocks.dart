// ignore_for_file: deprecated_member_use

import 'package:faker/faker.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';

// Mock da resposta da lista de feeds
final rawFeedListJsonMock = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": List.generate(
      10,
      (index) => {
            'id': index,
            'title': faker.lorem.words(3).join(' '),
            'text': faker.lorem.sentence(),
            'date': faker.date.dateTime().toString(),
            'image': faker.image.image(),
          })
};
final rawFeedListContent =
    rawFeedListJsonMock['data'] as List<Map<String, dynamic>>;

// Mock da resposta de detalhe de um único feed
final rawSingleFeedJsonMock = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": {
    'id': faker.randomGenerator.integer(100),
    'title': faker.lorem.words(3).join(' '),
    'text': faker.lorem.sentence(),
    'date': faker.date.dateTime().toString(),
    'link_type': faker.lorem.word(),
    'link': faker.internet.httpsUrl(),
    'image': faker.image.image(),
  }
};
final rawSingleFeedContent =
    rawSingleFeedJsonMock['data'] as Map<String, dynamic>;

// Lista de feed formatada como FeedEntity
final formattedFeedListMock =
    rawFeedListContent.map((e) => FeedEntity.fromJson(e)).toList();

// Feed único formatado como FeedEntity
final formattedSingleFeedMock = FeedEntity.fromJson(rawSingleFeedContent);

// Mock de um único feed com archive
final rawSingleFeedWithArchiveJsonMock = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": {
    'id': faker.randomGenerator.integer(100),
    'title': faker.lorem.words(3).join(' '),
    'text': '<p>Hello<br>World</p>',
    'date': faker.date.dateTime().toString(),
    'link_type': 'archive',
    'link': faker.internet.httpsUrl(),
    'image': faker.image.image(),
  }
};

// Mock de um único feed com video
final rawSingleFeedWithVideoJsonMock = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": {
    'id': faker.randomGenerator.integer(100),
    'title': faker.lorem.words(3).join(' '),
    'text': '<p>Hello<br>World</p>',
    'date': faker.date.dateTime().toString(),
    'link_type': 'video',
    'link': faker.internet.httpsUrl(),
    'image': faker.image.image(),
  }
};
