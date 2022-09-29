import 'package:equatable/equatable.dart';
import 'error_pop.dart';
import 'loading.dart';

abstract class BaseState<STATE> with EquatableMixin {
  LoadingIndicatorViewModel get loader;
  ErrorPopup get error;

  const BaseState();

  STATE copyWith({
    LoadingIndicatorViewModel loader = const LoadingIndicatorViewModel.loaded(),
    ErrorPopup? error,
  });

  STATE loading() {
    return copyWith(
      loader: const LoadingIndicatorViewModel.loading(),
    );
  }

  STATE withError(ErrorPopup error) {
    return copyWith(
      error: error,
    );
  }
}
