import 'package:equatable/equatable.dart';

class TaskViewModel extends Equatable {
  final String title;
  final List<RowsData> rows;
  final List<RowsData> filtered;

  const TaskViewModel(
      {required this.title, required this.rows, required this.filtered});

  @override
  List<Object?> get props => [title, rows, filtered];
  const TaskViewModel.initialized()
      : this(title: "", rows: const [], filtered: const []);
}

class RowsData extends Equatable {
  final String title;
  final String description;
  final String imageHref;

  const RowsData(
      {required this.title,
      required this.description,
      required this.imageHref});
  @override
  List<Object?> get props => [
        title,
        description,
        imageHref,
      ];
  const RowsData.initialized()
      : this(
          title: "",
          description: "",
          imageHref: "https://via.placeholder.com/150x150",
        );
}
