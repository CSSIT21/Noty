import 'package:flutter/material.dart';

List<Widget> dividerInsert(List<Widget> widgets, Widget divider) {
  return widgets.fold(<Widget>[], (previousValue, element) {
    previousValue.add(element);
    if (element != widgets.last) {
      previousValue.add(divider);
    }
    return previousValue;
  });
}
