part of 'selected_item_cubit.dart';

class SelectedItemState {
  Aircraft? _aircraft;
  Airport? _airport;

  Aircraft? get aircraft => _aircraft;
  Airport? get airport => _airport;


  SelectedItemState();

  factory SelectedItemState.withAircraft(Aircraft aircraft) {
    final state = SelectedItemState();
    state._aircraft = aircraft;
    return state;
  }

  factory SelectedItemState.withAirport(Airport airport) {
    final state = SelectedItemState();
    state._airport = airport;
    return state;
  }
}
