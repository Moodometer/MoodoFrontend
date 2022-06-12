import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import '../../../native_widgets/widget_data.dart';
import 'custom_appearance.dart';

class SliderLabel extends StatelessWidget {
  final double value;
  final CircularSliderAppearance appearance;
  const SliderLabel({Key? key, required this.value, required this.appearance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: builtInfo(appearance),
    );
  }

  List<Widget> builtInfo(CircularSliderAppearance appearance) {
    var widgets = <Widget>[];
    if (appearance.infoTopLabelText != null) {
      widgets.add(Text(
        appearance.infoTopLabelText!,
        style: appearance.infoTopLabelStyle,
      ));
    }
    final modifier = appearance.infoModifier(value);

    //TODO: Test implementation of Widget
    WidgetKit.setItem(
        'widgetData',
        jsonEncode([
          WidgetData(modifier),
          WidgetData(appearance.infoModifier(10)),
          WidgetData(appearance.infoModifier(99)),
          WidgetData(appearance.infoModifier(50))
        ]),
        'group.app.moodometer.widgetGroup');
    WidgetKit.reloadAllTimelines();

    widgets.add(
      Text(modifier, style: appearance.infoMainLabelStyle),
    );
    if (appearance.infoBottomLabelText != null) {
      widgets.add(Text(
        appearance.infoBottomLabelText!,
        style: appearance.infoBottomLabelStyle,
      ));
    }
    return widgets;
  }
}
