import 'package:get/get.dart';
import 'package:learncoding/routes/routing_constants.dart';
import 'package:learncoding/ui/pages/landing_page/index.dart';
import 'package:learncoding/ui/pages/programming_language/controller.dart';
import 'package:learncoding/ui/pages/programming_language/programing_options.dart';
import 'package:learncoding/ui/pages/video.dart';

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
];
