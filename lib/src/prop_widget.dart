import 'package:flutter/widgets.dart';

abstract class PropWidget<T> with PropWidgetBase<T> {
  Widget builder(BuildContext context, T value, ValueChanged<T> onChanged);
}

mixin PropWidgetBase<T> {
  void dispose() {}
  void init(T initialData) {}
}
