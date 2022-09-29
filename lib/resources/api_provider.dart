import 'dart:convert';

import 'package:http/http.dart' as http;
import '../fearture/models/task_model.dart';

class ApiProvider {
  final String _url =
      'https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf';

  /// hitting api by using Dio Library  to All call like get, post,put and patch calls
  Future<TaskModel> fetchApiDataList() async {
    try {
      var response = await http.get(Uri.parse(_url));
      return TaskModel.fromJson(jsonDecode(response.body));
    } catch (exception) {
      return TaskModel.withError("Data not found / Connection issue");
    }
  }
}
