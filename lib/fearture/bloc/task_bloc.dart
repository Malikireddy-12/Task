import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/error_handler_enum.dart';
import '../../common/error_pop.dart';
import '../../common/loading.dart';
import '../../resources/api_repository.dart';
import 'task_view_model.dart';
import 'task_state.dart';

class TaskBloc extends Cubit<TaskState> {
  /// ApiRepository to get api call instance
  final ApiRepository apiRepository = ApiRepository();

  TaskBloc() : super(const TaskState.initialized());

  /// hitting  api call h
  void getResultsApi() async {
    try {
      /// Before api call we are showing Loader here Loader is mark as a true
      emit(state.copyWith(
        loader: const LoadingIndicatorViewModel.loading(),
        taskModel: const TaskViewModel.initialized(),
      ));

      ///  api calling with  function [fetchApiDataList]
      final mList = await apiRepository.fetchApiDataList();

      ///  here we are updateing data to stata or View model
      emit(
        state.copyWith(
          taskModel: TaskViewModel(
              title: mList.title!,
              rows: mList.rows!
                  .map(
                    (e) => RowsData(
                        title: e.title ?? "",
                        description: e.description ?? "",
                        imageHref: e.imageHref ?? ""),
                  )
                  .toList(),
              filtered: mList.rows!
                  .map(
                    (e) => RowsData(
                        title: e.title ?? "",
                        description: e.description ?? "",
                        imageHref: e.imageHref ?? ""),
                  )
                  .toList()),
        ),
      );

      ///  here we are updating  Error Data
      if (mList.error != null) {
        emit(state.copyWith(
            error: const ErrorPopup(
                id: 1,
                errorCode: ErrorHandlerEnum.Error_401,
                title: "title",
                description: "description")));
      }
    } on NetworkError {
      ///  here we are updating  NetworkError
      emit(state.copyWith(
          error: const ErrorPopup(
              id: 1,
              errorCode: ErrorHandlerEnum.Error_401,
              title: "title",
              description: "Failed to fetch data. is your device online?")));
    }
  }

  ///Search Functionality Implement on this [filterSearchResults]
  void filterSearchResults(String query, TaskViewModel taskModel) {
    if (query.trim().length > 2) {
      List<RowsData> dummyListData = [];
      for (var element in taskModel.rows) {
        ///Here [query] text   we are find [element.title.contains(query)] it will retrun bool
        if (element.title.contains(query)) {
          dummyListData.add(element);
        }
      }
      emit(
        state.copyWith(
          taskModel: TaskViewModel(
              title: taskModel.title,
              rows: taskModel.rows,
              filtered: dummyListData),
        ),
      );
    } else {
      taskModel.filtered.clear;
      emit(
        state.copyWith(
          taskModel: TaskViewModel(
              title: taskModel.title,
              rows: taskModel.rows,
              filtered: taskModel.rows),
        ),
      );
    }
  }
}
