import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:modular_testing/app/app_module.dart';
import 'package:modular_testing/app/modules/home/home_module.dart';

import 'package:modular_testing/app/modules/home/home_page.dart';

void main() {
  setUpAll(() {
    initModules([AppModule(), HomeModule()]);
  });
  testWidgets('HomePage has title', (tester) async {
    await tester.pumpWidget(buildTestableWidget(HomePage(title: 'Home')));
    final titleFinder = find.text('Home');
    expect(titleFinder, findsOneWidget);
  });
}
