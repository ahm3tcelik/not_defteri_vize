import 'package:get/get.dart';
import 'middlewares/index.dart';
import 'views/index.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
        name: AppRoutes.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware()]
    ),
    GetPage(name: AppRoutes.SIGN_IN, page: () => SignInView(), binding: SignInBinding()),
    GetPage(name: AppRoutes.SIGN_UP, page: () => SignUpView(), binding: SignUpBinding())
  ];
}

abstract class AppRoutes {
  static const INITIAL = '/home';
  static const SIGN_IN = '/signin';
  static const SIGN_UP = '/signup';
  static const HOME = '/home';
}
