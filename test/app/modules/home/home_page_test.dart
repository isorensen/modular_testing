import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_testing/app/app_module.dart';
import 'package:modular_testing/app/modules/home/home_controller.dart';
import 'package:modular_testing/app/modules/home/home_module.dart';

import 'package:modular_testing/app/modules/home/home_page.dart';
import 'package:modular_testing/app/modules/home/pages/second/second_page.dart';

import '../../../shared.dart';

class MockNavObserver extends Mock implements NavigatorObserver {}

class MyNavigatorMock extends Mock implements IModularNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  HomeController home;
  var appRouters;
  var homeRouters;

  setUpAll(() {
    initModules([AppModule(), HomeModule()]);
    home = HomeModule.to.get<HomeController>();

    // Initialize routers
    appRouters = AppModule().routers;
    homeRouters = HomeModule().routers;
  });

  test('HomeController test', () {
    expect(home, isA<HomeController>());
  });

  testWidgets('HomePage has title', (tester) async {
    await tester.pumpWidget(buildTestableWidget(HomePage(title: 'Home')));
    final titleFinder = find.text('Home');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Navigate to second page using Modular.to without Mocking', (tester) async {
    var mockNavigator = MockNavObserver();
    await tester.pumpWidget(makeTestableWidget(HomePage(), mockNavigator));
    final buttonFinder = find.byKey(Key('modularButton'));
    expect(buttonFinder, findsOneWidget);

    expect(appRouters, isNotNull);
    expect(homeRouters, isNotNull);
    await tester.pumpAndSettle();

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    verify(mockNavigator.didPush(any, any));

    final newPageFinder = find.byType(SecondPage);
    expect(newPageFinder, findsOneWidget);
  });

  testWidgets('Navigate to second page using Modular.to', (tester) async {
    /// The line below makes the test pass
    /// However you cannot check if it actually was pushed to SecondPage,
    /// since it doesn't actually push the page
    Modular.navigatorDelegate = MyNavigatorMock();
    var mockNavigator = MockNavObserver();
    await tester.pumpWidget(makeTestableWidget(HomePage(), mockNavigator));
    final buttonFinder = find.byKey(Key('modularButton'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    verify(mockNavigator.didPush(any, any));

    final newPageFinder = find.byType(SecondPage);
    //! Line below does not find any widget, since it didn't actually was pushed
    expect(newPageFinder, findsOneWidget);
  });

  testWidgets('Navigate to second page using Navigator', (tester) async {
    var mockNavObserver = MockNavObserver();
    await tester.pumpWidget(makeTestableWidget(HomePage(), mockNavObserver));
    final buttonFinder = find.byKey(Key('navigatorButton'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    verify(mockNavObserver.didPush(any, any));

    final newPageFinder = find.byType(SecondPage);
    expect(newPageFinder, findsOneWidget);
  });
}
