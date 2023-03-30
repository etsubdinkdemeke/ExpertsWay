import 'package:get/get.dart';
import 'package:expertsway/auth/auth.dart';
import 'package:expertsway/routes/routing_constants.dart';
import 'package:expertsway/ui/pages/landing_page/index.dart';
import 'package:expertsway/ui/pages/programming_language/controller.dart';
import 'package:expertsway/ui/pages/programming_language/programing_options.dart';
import 'package:expertsway/ui/pages/video.dart';

import '../auth/verification.dart';

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
  GetPage(
      name: AppRoute.verificationPage,
      page: () => VerificationPage(email: email)),
];
