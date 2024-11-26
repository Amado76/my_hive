// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/presentation/bloc/feed/feed_bloc.dart';

void main() {
  group('[LoadFeed]', () {
    test('supports value comparisons', () {
      expect(LoadFeed(), LoadFeed());
    });
  });

  // group('[GetSingleFeedDetails]', () {
  //   test('supports value comparisons', () {
  //     expect(
  //       GetSingleFeedDetails(formattedSingleFeedMock),
  //       GetSingleFeedDetails(formattedSingleFeedMock),
  //     );
  //   });
  // });
}
