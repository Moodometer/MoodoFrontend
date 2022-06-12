import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moodometer/presentation/home/widgets/custom_appearance.dart';
import 'package:moodometer/presentation/home/widgets/mood_page.dart';
import 'package:uni_links/uni_links.dart';
//import 'package:moodometer/presentation/shared/speedometer/speedometer.dart';
//import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

CircularSliderAppearance customappearance = CircularSliderAppearance(
  size: 300.0,
  infoProperties: InfoProperties(
      bottomLabelStyle: const TextStyle(fontSize: 20),
      bottomLabelText:
          '' /* viewModel.value <= 10
        ? '😭'
        : viewModel.value <= 20
            ? '😢'
            : viewModel.value <= 30
                ? '😐'
                : viewModel.value <= 40
                    ? '😊'
                    : viewModel.value <= 50
                        ? '😄'
                        : viewModel.value <= 60
                            ? '😁'
                            : viewModel.value <= 70
                                ? '😀'
                                : viewModel.value <= 80
                                    ? '😃'
                                    : viewModel.value <= 90
                                        ? '😆'
                                        : '😡', */
      ),
);
final viewModel = MoodViewModel(
  appearance: customappearance,
  min: 0,
  max: 100,
  value: 60,
  pageColors: [Colors.white, const Color(0xFFE1C3FF)],
  //innerWidget: ,
);
final MoodSlider = MoodPage(
  viewModel: viewModel,
);

class _HomeScreenState extends State<HomeScreen> {
  var url = "None";

  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      setState(() {
        url = initialLink ?? "none";
      });
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //int currentValue = 100;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Center(child: Image.asset('assets/Logo_white.png')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Row(
          children: [
            Text("URL: ${url}"),
          ],
        ),
      ),
    );
  }
}
//🙂, 😃, 😱, 🥳, 😡,

/* Speedometer(
          minValue: 0,
          maxValue: 100,
          currentValue: currentValue,
          displayText: currentValue <= 10
              ? '😭'
              : currentValue <= 20
                  ? '😢'
                  : currentValue <= 30
                      ? '😐'
                      : currentValue <= 40
                          ? '😊'
                          : currentValue <= 50
                              ? '😄'
                              : currentValue <= 60
                                  ? '😁'
                                  : currentValue <= 70
                                      ? '😀'
                                      : currentValue <= 80
                                          ? '😃'
                                          : currentValue <= 90
                                              ? '😆'
                                              : '😡',
        ), */