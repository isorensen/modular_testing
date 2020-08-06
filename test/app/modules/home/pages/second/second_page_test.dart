import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:modular_testing/app/app_module.dart';
import 'package:modular_testing/app/modules/home/home_module.dart';

import 'package:modular_testing/app/modules/home/pages/second/second_page.dart';

void main() {
  setUpAll(() {
    initModules([AppModule(), HomeModule()]);
  });
  testWidgets('SecondPage has title', (tester) async {
    await tester.pumpWidget(buildTestableWidget(SecondPage(title: 'Second')));
    final titleFinder = find.text('Second');
    expect(titleFinder, findsOneWidget);
  });
}
