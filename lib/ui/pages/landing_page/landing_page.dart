import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:expertsway/routes/routing_constants.dart';
import 'package:expertsway/theme/box_icons_icons.dart';
import 'package:expertsway/ui/pages/course_detail.dart';
import 'package:expertsway/ui/pages/landing_page/index.dart';
import 'package:expertsway/ui/pages/setting.dart';
import 'package:expertsway/ui/widgets/gradient_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:expertsway/ui/pages/notification.dart' as notificationPage;
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Obx(() {
      return controller.loading.value
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: ButtonThemeData(
                  buttonColor: themeProvider.currentTheme == ThemeData.dark() ? Colors.white : Colors.black,
                ),
              ),
              child: Scaffold(
                key: controller.scaffoldKey,
                backgroundColor: themeProvider.currentTheme == ThemeData.light() ? Colors.white : const Color.fromARGB(255, 25, 32, 36),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: themeProvider.currentTheme == ThemeData.light() ? Colors.white : Color.fromARGB(255, 25, 32, 36),
                  shadowColor: Colors.transparent,
                  centerTitle: true,
                  leading: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: InkWell(
                          onTap: () {
                            controller.scaffoldKey.currentState?.openDrawer();
                          },
                          child: Image.asset(
                            themeProvider.currentTheme == ThemeData.light() ? 'assets/images/drawer_icon.png' : 'assets/images/drawer_icon_white.png',
                            height: 20,
                            width: 20,
                          )),
                    );
                  }),
                  leadingWidth: 60,
                  title: _Header(
                    theme: theme,
                    controller: controller,
                  ),
                  actions: [
                    Container(
                      padding: EdgeInsets.only(right: 10, top: 15),
                      child: InkWell(
                        onTap: () => Get.to(() => const notificationPage.Notification()),
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Icon(Icons.notifications_none_rounded,
                                size: 28,
                                color: themeProvider.currentTheme == ThemeData.dark()
                                    ? const Color.fromARGB(255, 221, 221, 221)
                                    : Color.fromARGB(255, 63, 63, 63).withOpacity(0.8)),
                            const Positioned(
                                top: 4,
                                right: 4,
                                child: CircleAvatar(
                                  maxRadius: 5,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(maxRadius: 4, backgroundColor: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                drawer: Drawer(
                  elevation: 1,
                  backgroundColor: themeProvider.currentTheme == ThemeData.light() ? Colors.white : Color.fromARGB(255, 25, 32, 36),
                  child: SafeArea(
                    child: ListView(
                      children: [
                        _DrawerHeader(controller, theme),
                        _DrawerButton(
                          onPress: () {
                            controller.scaffoldKey.currentState?.closeDrawer();
                            Get.toNamed(AppRoute.landingPage);
                          },
                          theme: theme,
                          icon: BoxIcons.bx_home,
                          name: 'Home',
                        ),
                        _DrawerButton(
                          onPress: () {},
                          theme: theme,
                          icon: BoxIcons.bx_notepad,
                          name: 'To-do',
                        ),
                        _DrawerButton(
                          onPress: () {},
                          theme: theme,
                          icon: Icons.play_arrow_outlined,
                          name: 'Videos',
                        ),
                        _DrawerButton(
                          onPress: () {},
                          theme: theme,
                          icon: BoxIcons.bx_line_chart,
                          name: 'Leaderboard',
                        ),
                        _DrawerButton(
                          onPress: () {},
                          theme: theme,
                          icon: BoxIcons.bx_calendar_week,
                          name: 'calendar',
                        ),
                        _DrawerButton(
                          onPress: () {},
                          theme: theme,
                          icon: BoxIcons.bx_message_square_dots,
                          name: 'Forums',
                        ),
                        const Divider(),
                        _DrawerButton(
                          onPress: () => Get.to(() => const Settings()),
                          theme: theme,
                          icon: BoxIcons.bx_cog,
                          name: 'Settings',
                        ),
                        _DrawerButton(
                          onPress: () {},
                          theme: theme,
                          icon: BoxIcons.bx_help_circle,
                          name: 'Help',
                        ),
                        _DrawerButton(
                          onPress: () {},
                          theme: theme,
                          icon: BoxIcons.bx_log_out,
                          name: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
                body: DoubleBackToCloseApp(
                  snackBar: SnackBar(
                    backgroundColor: theme.colorScheme.background,
                    content: Text(
                      'Press back button again to exit'.tr,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.shadowColor),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                              delegate: SliverChildListDelegate([
                            // _Header(
                            //   theme: theme,
                            //   controller: controller,
                            // ),
                            const SizedBox(height: 12),

                            // search input field
                            const _SerachTextField(),

                            // header
                            _LanguageHeader(
                              theme: theme,
                              showButton: true,
                              title: 'Popular languages',
                            ),

                            _ListOfProgrammingLanguages(controller),

                            const SizedBox(height: 12),

                            // header
                            _LanguageHeader(
                              theme: theme,
                              showButton: false,
                              title: 'Recommended courses',
                            ),

                            const SizedBox(height: 12),

                            AlignedGridView.count(
                                shrinkWrap: true,
                                mainAxisSpacing: 20,
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                itemCount: controller.course.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => CourseDetailPage(
                                          courseData: controller.course[index],
                                        ),
                                      );
                                    },
                                    child: _CardWidget(owned: false, index: index, theme: theme, controller: controller),
                                  );
                                }),
                            const SizedBox(height: 12),
                            if (controller.userCourses.isNotEmpty)
                              _LanguageHeader(
                                theme: theme,
                                showButton: false,
                                title: 'Your Courses',
                              ),

                            const SizedBox(height: 12),

                            AlignedGridView.count(
                                shrinkWrap: true,
                                mainAxisSpacing: 20,
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                itemCount: controller.userCourses.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => CourseDetailPage(
                                          courseData: controller.userCourses[index],
                                        ),
                                      );
                                    },
                                    child: _CardWidget(owned: true, index: index, theme: theme, controller: controller),
                                  );
                                })
                          ])),

                          // landing page header
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    });
  }
}

class _ListOfProgrammingLanguages extends StatelessWidget {
  final LandingPageController controller;
  const _ListOfProgrammingLanguages(this.controller);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...controller.course.map((item) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientBtn(
                  onPressed: () {
                    Get.to(() => CourseDetailPage(
                          courseData: item,
                        ));
                  },
                  btnName: item.name,
                  iconUrl: item.icon,
                  defaultBtn: false,
                  borderRadius: 20,
                ),
              ))
        ],
      ),
    );
  }
}

class _SerachTextField extends StatelessWidget {
  const _SerachTextField();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color backgroundColor = Theme.of(context).cardColor;
    IconThemeData icon = Theme.of(context).iconTheme;
    return Container(
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            blurRadius: 20,
            color: themeProvider.currentTheme == ThemeData.light() ? Colors.grey.shade300 : Colors.transparent,
            spreadRadius: -6,
            offset: const Offset(-1, 8))
      ]),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Color.fromARGB(90, 166, 165, 165), fontSize: 18, fontWeight: FontWeight.w400),
          hintText: 'Search any course',
          prefixIcon: Icon(
            Icons.search,
            color: themeProvider.currentTheme == ThemeData.light() ? Color.fromARGB(90, 45, 45, 45) : Color.fromARGB(90, 183, 182, 182),
          ),
          border: InputBorder.none,
        ),
        onChanged: (val) {
          if (kDebugMode) print(val);
        },
      ),
    );
  }
}

class _LanguageHeader extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final bool showButton;
  const _LanguageHeader({required this.theme, required this.title, required this.showButton});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
          if (showButton)
            TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 14),
                ))
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ThemeData theme;
  final LandingPageController controller;
  const _Header({required this.theme, required this.controller});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width - 300) / 2,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: textTheme.headline2?.copyWith(fontSize: 15, fontWeight: FontWeight.w300),
            ),
            Text(
              controller.profileName ?? 'User',
              style: textTheme.headline1?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width - 300) / 2,
        ),
      ],
    );
  }
}

class _CardWidget extends StatelessWidget {
  final int index;
  final ThemeData theme;
  final LandingPageController controller;
  final bool owned; // this flag tells if this is a userCourse or just a course. a userCourse means the user has started learning it.

  const _CardWidget({
    required this.index,
    required this.theme,
    required this.controller,
    required this.owned,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color backgroundColor = Theme.of(context).cardColor;
    var courseList = owned ? controller.userCourses : controller.course;
    return Container(
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            blurRadius: 20,
            color: themeProvider.currentTheme == ThemeData.light() ? Colors.grey.shade300 : Colors.transparent,
            spreadRadius: -6,
            offset: const Offset(-1, 8))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: courseList[index].banner,
              height: 70,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              courseList[index].name,
              style: textTheme.bodyText2?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: courseList[index].icon,
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Beginner',
                      style: textTheme.headline6?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '20hr',
                      style: textTheme.headline6?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.timer_sharp,
                      size: 16,
                      color: Colors.grey.shade400,
                    )
                  ],
                )
              ],
            ),
          ),
          if (owned) ...[
            LinearPercentIndicator(
              percent: controller.progressList.firstWhere((element) => element.courseId == courseList[index].courseId.toString()).percentage,
              backgroundColor: Colors.grey.shade200,
              progressColor: const Color(0xff26B0FF),
              animation: true,
              animationDuration: 1000,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Completed',
                    style: textTheme.headline6?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${(controller.progressList.firstWhere((element) => element.courseId == courseList[index].courseId.toString()).percentage * 100).round()}%',
                    style: textTheme.headline6?.copyWith(fontSize: 12, color: const Color(0xff26B0FF)),
                  ),
                ],
              ),
            ),
          ],
          if (!owned)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Color(0xffFCEA2B),
                      ),
                      Text(
                        '4.9',
                        style: textTheme.headline6?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Enroll Now',
                        style: textTheme.headline6?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 4),
                      const CircleAvatar(
                        backgroundColor: Color.fromARGB(80, 38, 175, 255),
                        maxRadius: 10,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: Color(0xff26B0FF),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final LandingPageController controller;
  final ThemeData theme;
  const _DrawerHeader(this.controller, this.theme);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: controller.profileImage == null
                ? Image.asset(
                    'assets/images/profile_placeholder.png',
                    height: 60,
                    width: 60,
                  )
                : CachedNetworkImage(
                    imageUrl: controller.profileImage!,
                    height: 60,
                    width: 60,
                  ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.profileName ?? '',
                style: textTheme.headline1?.copyWith(fontSize: 19, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              Text(
                'Student',
                style: textTheme.headline2?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  final Function()? onPress;
  final ThemeData theme;
  final IconData icon;
  final String name;
  const _DrawerButton({
    required this.onPress,
    required this.theme,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: themeProvider.currentTheme == ThemeData.dark() ? Color.fromARGB(64, 38, 176, 255) : const Color(0xff26B0FF),
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: themeProvider.currentTheme == ThemeData.dark() ? Color.fromARGB(64, 38, 176, 255) : Colors.lightBlue[100],
                child: Icon(
                  icon,
                  size: 20,
                  color: themeProvider.currentTheme == ThemeData.dark()
                      ? const Color.fromARGB(255, 221, 221, 221)
                      : Color.fromARGB(255, 63, 63, 63).withOpacity(0.8),
                ),
              ),
              const SizedBox(width: 28),
              Text(
                name,
                style: textTheme.headline2?.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
