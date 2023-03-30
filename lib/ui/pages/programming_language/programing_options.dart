import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expertsway/routes/routing_constants.dart';
import 'package:expertsway/ui/pages/programming_language/controller.dart';
import 'package:expertsway/ui/widgets/gradient_button.dart';

class ProgrammingOptions extends GetView<ProgrammingOptionsController> {
  const ProgrammingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text(
              'What do you wish to master',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Red Hat Display',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pick at least 3 languages',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Red Hat Display',
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 9 / 3),
                itemCount: controller.programmingOptionsModels.length,
                itemBuilder: (_, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: GradientBtn(
                      defaultBtn: false,
                      onPressed: () {
                        controller.onSelectButton(index);
                      },
                      btnName:
                          controller.programmingOptionsModels[index].btnName,
                      iconUrl:
                          controller.programmingOptionsModels[index].iconUrl,
                      isPcked:
                          controller.programmingOptionsModels[index].isPicked,
                    ),
                  );
                }),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Opacity(
                opacity: controller.pickedLanguages.length > 2 ? 1 : 0.3,
                child: GradientBtn(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.landingPage);
                  },
                  btnName: 'Get Started',
                  defaultBtn: true,
                  isPcked: false,
                  width: 200,
                  height: 52,
                ),
              ),
            )
          ],
        );
      }),
    ));
  }
}
