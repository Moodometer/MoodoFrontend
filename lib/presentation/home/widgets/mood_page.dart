import 'package:flutter/material.dart';
import 'package:moodometer/data/models/user.model.dart';
import 'package:moodometer/presentation/home/widgets/circular_slider.dart';
import 'package:moodometer/presentation/home/widgets/custom_appearance.dart';

class MoodViewModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget? innerWidget;

  MoodViewModel(
      {required this.pageColors,
      required this.appearance,
      this.min = 0,
      this.max = 100,
      this.value = 50,
      this.innerWidget});
}

class MoodPage extends StatelessWidget {
  final MoodViewModel viewModel;
  final UserModel user;
  const MoodPage({
    Key? key,
    required this.viewModel,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: viewModel.pageColors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp)),
        child: SafeArea(
          child: Center(
              child: SleekCircularSlider(
            onChangeStart: (double value) {},
            onChangeEnd: (double value) {},
            innerWidget: viewModel.innerWidget,
            appearance: viewModel.appearance,
            min: viewModel.min,
            max: viewModel.max,
            initialValue:
                user.mood > 0 ? user.mood.toDouble() : viewModel.value,
          )),
        ),
      ),
    );
  }
}
