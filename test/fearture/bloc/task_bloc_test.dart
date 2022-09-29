import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:task_app/resources/api_provider.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('run.mocky', () {
    test('returns an run.mocky if the http call completes successfully',
        () async {
      //setup the test
      var apiProvider = ApiProvider();
      MockClient((request) async {
        var mapJson = {
          "title": "About Canada",
          "rows": [
            {
              "title": "Beavers",
              "description":
                  "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
              "imageHref":
                  "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
            }
          ]
        };
        return Response(jsonDecode(mapJson.toString()), 200);
      });

      final item = await apiProvider.fetchApiDataList();
      expect(item.title, "About Canada");
    });

    test('throws an exception if the http call completes with an error',
        () async {
      var apiProvider = ApiProvider();
      MockClient((request) async {
        var mapJson = {};
        return Response(jsonDecode(mapJson.toString()), 404);
      });
      final item = await apiProvider.fetchApiDataList();
      expect(item.error, null);
    });
  });
}
