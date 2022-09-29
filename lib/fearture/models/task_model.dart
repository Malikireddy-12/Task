class TaskModel {
  String? title;
  List<Rows>? rows;
  String? error;

  TaskModel({this.title, this.rows});
  TaskModel.withError(String errorMessage) {
    error = errorMessage;
  }

  TaskModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
  }
}

class Rows {
  String? title;
  String? description;
  String? imageHref;

  Rows({this.title, this.description, this.imageHref});

  Rows.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageHref = json['imageHref'];
  }
}
