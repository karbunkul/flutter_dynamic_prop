import 'package:flutter/widgets.dart';

abstract class PropWidget<T> {
  Widget builder(BuildContext context, T value, ValueChanged<T> onChanged);
  void dispose() {}
  void init(T initialData) {}
}
