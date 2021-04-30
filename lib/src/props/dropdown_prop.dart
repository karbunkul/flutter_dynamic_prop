import 'package:dynamic_prop/dynamic_prop.dart';
import 'package:flutter/material.dart';

class DropdownPropItem<T> {
  final String title;
  final T? value;

  DropdownPropItem({required this.title, this.value});
}

class DropdownProp<T> extends PropWidget<T> {
  final List<DropdownPropItem<T>>? items;

  DropdownProp({this.items});

  @override
  Widget builder(BuildContext context, T value, ValueChanged<T>? onChanged) {
    List<DropdownMenuItem<T>> _items = items!.map((item) {
      return DropdownMenuItem<T>(
        value: item.value,
        child: Text(item.title),
      );
    }).toList();

    int index = items!.indexWhere((val) => identical(val.value, value));
    ValueChanged<T?>? _onChanged =
        onChanged != null ? (_) => onChanged(_!) : (_) => null;
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: items![(index != -1) ? index : 0].value,
        items: _items,
        onChanged: _onChanged,
      ),
    );
  }
}
