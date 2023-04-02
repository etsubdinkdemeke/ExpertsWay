import 'package:expertsway/routes/routing_constants.dart';
import 'package:get/get.dart';
import '../auth/auth.dart';
import '../auth/changepassword.dart';
import '../auth/forgotpassword.dart';
import '../auth/verification.dart';
import '../ui/pages/landing_page/controller.dart';
import '../ui/pages/landing_page/landing_page.dart';
import '../ui/pages/programming_language/controller.dart';
import '../ui/pages/programming_language/programing_options.dart';
import '../ui/pages/video.dart';

final String email = Get.arguments['email'];
final pages = [
  GetPage(name: AppRoute.videoPage, page: () => const VideoPage()),
  GetPage(
      name: AppRoute.landingPage,
      page: () => const LandingPage(),
      binding: BindingsBuilder(() {
        Get.put(LandingPageController());
      })),
  GetPage(
      name: AppRoute.programmingOptions,
      page: () => const ProgrammingOptions(),
      binding: BindingsBuilder(() {
        Get.put(ProgrammingOptionsController());
      })),
  GetPage(name: AppRoute.authPage, page: () => const AuthPage()),
  GetPage(name: AppRoute.verificationPage, page: () => VerificationPage(email: email)),
  GetPage(name: AppRoute.forgotpasswordPage, page: () => const ForgotPassword()),
  GetPage(name: AppRoute.changepasswordPage, page: () => ChangePassword(email: email)),
];
