import 'package:task_app/common/base_state.dart';
import 'package:task_app/common/loading.dart';
import '../../common/error_pop.dart';
import 'task_view_model.dart';

class TaskState extends BaseState<TaskState> {
  @override
  final LoadingIndicatorViewModel loader;
  @override
  final ErrorPopup error;
  final TaskViewModel taskModel;
  @override
  List<Object?> get props => [loader, error, taskModel];
  const TaskState(
      {required this.loader, required this.error, required this.taskModel});
  const TaskState.initialized()
      : this(
          loader: const LoadingIndicatorViewModel.initialized(),
          error: const ErrorPopup.initialized(),
          taskModel: const TaskViewModel(rows: [], title: '', filtered: []),
        );
  @override
  TaskState copyWith(
      {LoadingIndicatorViewModel loader =
          const LoadingIndicatorViewModel.loaded(),
      ErrorPopup? error,
      TaskViewModel? taskModel}) {
    return TaskState(
      loader: loader,
      error: error ?? this.error,
      taskModel: taskModel ?? this.taskModel,
    );
  }
}
