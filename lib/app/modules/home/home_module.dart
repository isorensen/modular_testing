import 'package:modular_testing/app/modules/home/pages/second/second_page.dart';

import 'pages/second/second_controller.dart';
import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SecondController()),
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
        Router('/second', child: (_, args) => SecondPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
