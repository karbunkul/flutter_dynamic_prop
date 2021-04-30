import 'prop_widget.dart';

class PropDefinition<T> {
  final String id;
  final T? initialData;
  final PropWidget<T> widget;

  PropDefinition({
    required this.id,
    required this.widget,
    this.initialData,
  });
}
