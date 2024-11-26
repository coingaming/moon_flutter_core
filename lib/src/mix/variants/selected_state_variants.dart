import 'package:mix/mix.dart';

class SelectedState extends Variant {
  const SelectedState._(super.name);

  static const selected = SelectedState._('selected');
  static const unselected = SelectedState._('unselected');
  static const indeterminate = SelectedState._('indeterminate');
}
