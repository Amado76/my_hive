// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/presentation/bloc/home_bloc.dart';

void main() {
  test('supports value comparisons ', () {
    expect(GetStudentHomeData(), GetStudentHomeData());
    expect(AcceptUserTerms(), AcceptUserTerms());
  });
}
