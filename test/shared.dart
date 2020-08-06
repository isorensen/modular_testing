import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

Widget makeTestableWidget(Widget child, [NavigatorObserver navigatorObserver]) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
      home: child,
      initialRoute: '/',
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      navigatorObservers: (navigatorObserver == null) ? [] : [navigatorObserver],
    ),
  );
}
