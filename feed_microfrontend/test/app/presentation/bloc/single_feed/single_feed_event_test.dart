// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/presentation/bloc/single_feed/single_feed_bloc.dart';

import '../../../../util/response_mocks.dart';

void main() {
  group('[GetSingleFeedDetails]', () {
    test('supports value comparisons', () {
      expect(
        GetSingleFeedDetails(formattedSingleFeedMock),
        GetSingleFeedDetails(formattedSingleFeedMock),
      );
    });
  });
}
