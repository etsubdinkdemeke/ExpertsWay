import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncoding/ui/pages/course_detail.dart';
import 'package:learncoding/ui/pages/landing_page/index.dart';
import 'package:learncoding/ui/widgets/gradient_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        _Header(
                          theme: theme,
                          controller: controller,
                        ),
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
                            crossAxisSpacing: 10,
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
                                child: _CardWidget(
                                    percent: null,
                                    index: index,
                                    theme: theme,
                                    controller: controller),
                              );
                            }),
                        const SizedBox(height: 12),

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
                            crossAxisSpacing: 10,
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
                                child: _CardWidget(
                                    percent: 60,
                                    index: index,
                                    theme: theme,
                                    controller: controller),
                              );
                            })
                      ])),

                      // landing page header
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class _ListOfProgrammingLanguages extends StatelessWidget {
  final LandingPageController controller;
  const _ListOfProgrammingLanguages(this.controller);

  @override
  Widget build(BuildContext context) {
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
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search any course',
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.grey.shade400,
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
  const _LanguageHeader(
      {required this.theme, required this.title, required this.showButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: Colors.grey.shade600),
          ),
          if (showButton)
            TextButton(onPressed: () {}, child: const Text('See all'))
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              if (kDebugMode) print('drawer');
            },
            child: Image.asset(
              'assets/images/drawer_icon.png',
              height: 17,
              width: 40,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
            Text(
              controller.profileName ?? 'User',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            if (kDebugMode) print('route to notification');
          },
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: const [
              Icon(
                Icons.notifications_none_rounded,
                size: 28,
              ),
              Positioned(
                  top: 4,
                  right: 4,
                  child: CircleAvatar(
                    maxRadius: 5,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(maxRadius: 4),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class _CardWidget extends StatelessWidget {
  final int index;
  final ThemeData theme;
  final LandingPageController controller;
  final int? percent;

  const _CardWidget({
    required this.index,
    required this.theme,
    required this.controller,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                color: Colors.grey.shade300,
                spreadRadius: -6,
                offset: const Offset(-1, 8))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: controller.course[index].banner,
              height: 70,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              controller.course[index].name,
              style: theme.textTheme.titleMedium,
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
                      imageUrl: controller.course[index].icon,
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Beginner',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '20hr',
                      style: theme.textTheme.bodySmall,
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
          if (percent != null) ...[
            LinearPercentIndicator(
              percent: 50 / 100,
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
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    '$percent%',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: const Color(0xff26B0FF)),
                  ),
                ],
              ),
            ),
          ],
          if (percent == null)
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
                        style:
                            theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Enroll Now',
                        style:
                            theme.textTheme.bodySmall?.copyWith(fontSize: 12),
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
