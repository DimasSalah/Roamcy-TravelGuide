import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_guide/utils/resources/resources.dart';

void main() {
  test('lotties assets test', () {
    expect(File(Lotties.cloudy).existsSync(), isTrue);
    expect(File(Lotties.rainy).existsSync(), isTrue);
    expect(File(Lotties.sunny).existsSync(), isTrue);
    expect(File(Lotties.thunder).existsSync(), isTrue);
  });
}
