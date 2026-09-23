import 'package:jaspr/jaspr.dart';

class ValueBuilder<T> extends StatefulComponent {
  final ValueNotifier<T> valueNotifier;
  final Component Function(BuildContext context, T value) builder;
  final void Function(T previous, T current)? onChange;

  const ValueBuilder({
    super.key,
    required this.valueNotifier,
    required this.builder,
    this.onChange,
  });

  @override
  State createState() => _ValueBuilderState<T>();
}

class _ValueBuilderState<T> extends State<ValueBuilder<T>> {
  late T _previousValue;
  @override
  void initState() {
    super.initState();
    _previousValue = component.valueNotifier.value;
    component.valueNotifier.addListener(_listener);
  }

  @override
  void dispose() {
    component.valueNotifier.removeListener(_listener);
    super.dispose();
  }

  @override
  void didUpdateComponent(ValueBuilder<T> oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.valueNotifier != component.valueNotifier) {
      oldComponent.valueNotifier.removeListener(_listener);
      _previousValue = component.valueNotifier.value;
      component.valueNotifier.addListener(_listener);
    }
  }

  void _listener() {
    final currentValue = component.valueNotifier.value;

    // Trigger the side effect before rebuilding
    if (component.onChange != null) {
      component.onChange!(_previousValue, currentValue);
    }
    _previousValue = currentValue;

    setState(() {});
  }

  @override
  Component build(BuildContext context) {
    return component.builder(context, component.valueNotifier.value);
  }
}
