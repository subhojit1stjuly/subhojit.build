import 'package:jaspr/jaspr.dart';

class ValueSelector<T, R> extends StatefulComponent {
  final ValueNotifier<T> notifier;
  final R Function(T state) selector;
  final Component Function(BuildContext context, R value) builder;

  const ValueSelector({
    super.key,
    required this.notifier,
    required this.selector,
    required this.builder,
  });

  @override
  State<ValueSelector<T, R>> createState() => _ValueSelectorState<T, R>();
}

class _ValueSelectorState<T, R> extends State<ValueSelector<T, R>> {
  late R selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = component.selector(component.notifier.value);
    component.notifier.addListener(_onNotifierChanged);
  }

  @override
  void dispose() {
    component.notifier.removeListener(_onNotifierChanged);
    super.dispose();
  }

  void _onNotifierChanged() {
    setState(() {
      selectedValue = component.selector(component.notifier.value);
    });
  }

  @override
  Component build(BuildContext context) {
    return component.builder(context, selectedValue);
  }
}
