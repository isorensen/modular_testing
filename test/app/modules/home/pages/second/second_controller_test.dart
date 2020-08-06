import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modular_testing/app/modules/home/pages/second/second_controller.dart';
import 'package:modular_testing/app/modules/home/home_module.dart';

void main() {
  initModule(HomeModule());
  SecondController second;

  setUp(() {
    second = HomeModule.to.get<SecondController>();
  });

  group('SecondController Test', () {
    test("First Test", () {
      expect(second, isInstanceOf<SecondController>());
    });
  });
}
