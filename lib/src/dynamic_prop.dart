import 'package:flutter/widgets.dart';
import 'prop_definition.dart';

typedef OnPropChange<T>(String id, T value);

typedef Widget PropBuilder(BuildContext context, Widget child);

class DynamicProp<T> extends StatefulWidget {
  final PropDefinition<T> definition;
  final OnPropChange<T> onPropChange;
  final PropBuilder builder;
  final T initialData;

  const DynamicProp({
    Key key,
    @required this.definition,
    this.onPropChange,
    this.builder,
    this.initialData,
  }) : super(key: key);

  @override
  _DynamicPropState<T> createState() => _DynamicPropState<T>();
}

class _DynamicPropState<T> extends State<DynamicProp<T>> {
  T _value;

  @override
  void initState() {
    initProp();
    super.initState();
  }

  initProp() {
    _value = widget.initialData ?? widget.definition.initialData;
    widget.definition.widget.init(_value);
  }

  @override
  void didUpdateWidget(DynamicProp oldWidget) {
    if (widget.definition.id != oldWidget.definition.id ||
        widget.definition.initialData != oldWidget.definition.initialData) {
      initProp();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var onChanged = (T newValue) {
      setState(() {
        if (identical(_value, newValue) == false) {
          _value = newValue;
          widget.onPropChange(widget.definition.id, newValue);
        }
      });
    };

    Widget child = widget.definition.widget.builder(context, _value, onChanged);
    if (widget.builder != null) {
      return widget.builder(context, child);
    }
    return child;
  }

  @override
  void dispose() {
    super.dispose();
    widget?.definition?.widget?.dispose();
  }
}
