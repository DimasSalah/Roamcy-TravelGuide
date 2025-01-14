import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_guide/utils/resources/resources.dart';

void main() {
  test('svgs assets test', () {
    expect(File(SVGs.googleColorSvgrepoCom).existsSync(), isTrue);
    expect(File(SVGs.instagram).existsSync(), isTrue);
    expect(File(SVGs.onboarding1).existsSync(), isTrue);
    expect(File(SVGs.onboarding2).existsSync(), isTrue);
    expect(File(SVGs.onboarding3).existsSync(), isTrue);
    expect(File(SVGs.q1).existsSync(), isTrue);
    expect(File(SVGs.q2).existsSync(), isTrue);
    expect(File(SVGs.q3).existsSync(), isTrue);
    expect(File(SVGs.q4).existsSync(), isTrue);
    expect(File(SVGs.q5).existsSync(), isTrue);
  });
}
