import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learncoding/models/programming_options_model.dart';
import 'package:learncoding/ui/widgets/gradient_button.dart';

class ProgrammingOptions extends StatefulWidget {
  const ProgrammingOptions({super.key});

  @override
  State<ProgrammingOptions> createState() => _ProgrammingOptionsState();
}

class _ProgrammingOptionsState extends State<ProgrammingOptions> {
  List<ProgrammingOptionsModel> pickedLanguages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
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
              itemCount: ProgrammingOptionsModels.length,
              itemBuilder: (_, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: GradientBtn(
                    defaultBtn: false,
                    onPressed: () {
                      setState(() {
                        ProgrammingOptionsModels[index].whiteBtn =
                            !ProgrammingOptionsModels[index].whiteBtn;
                        !ProgrammingOptionsModels[index].whiteBtn
                            ? pickedLanguages
                                .add(ProgrammingOptionsModels[index])
                            : pickedLanguages
                                .remove(ProgrammingOptionsModels[index]);
                      });
                    },
                    btnName: ProgrammingOptionsModels[index].btnName,
                    iconUrl: ProgrammingOptionsModels[index].iconUrl,
                    whiteBtn: ProgrammingOptionsModels[index].whiteBtn,
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GradientBtn(
              onPressed: pickedLanguages.length > 2
                  ? () {
                      if (kDebugMode) print(pickedLanguages);
                    }
                  : null,
              btnName: 'Get Started',
              defaultBtn: true,
              whiteBtn: false,
              width: 200,
            ),
          )
        ],
      ),
    ));
  }
}
