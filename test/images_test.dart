import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_guide/utils/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.logo).existsSync(), isTrue);
  });
}
