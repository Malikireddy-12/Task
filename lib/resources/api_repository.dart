import '../fearture/models/task_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<TaskModel> fetchApiDataList() {
    return _provider.fetchApiDataList();
  }
}

class NetworkError extends Error {}
