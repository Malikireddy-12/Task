import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:task_app/fearture/bloc/task_view_model.dart';
import 'package:task_app/fearture/view/about_canada_page.dart';
import 'package:task_app/fearture/view/widgets/list_view_widget.dart';
import 'package:task_app/resources/api_provider.dart';

void main() {
  var apiProvider = ApiProvider();
  setUp(() async {
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
  });
  testWidgets('about canada page ...', (tester) async {
    final item = await apiProvider.fetchApiDataList();
    // Create the widget by telling the tester to build it.
    var data = TaskViewModel(
      title: item.title ?? "",
      rows: item.rows != null
          ? item.rows!
              .map(
                (e) => RowsData(
                    title: e.title ?? "",
                    description: e.description ?? "",
                    imageHref: e.imageHref ?? ""),
              )
              .toList()
          : [],
      filtered: const [],
    );
    await tester.pumpWidget(const AboutCanadaPage());

    // Create the Finders.
    // final titleFinder = find.text(item.title!);
    // final tounter = find.byWidget(ListViewWidget(model: data.rows));

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(find.byWidget(ListViewWidget(model: data.rows)), findsOneWidget);
    // expect(tounter, findsOneWidget);
  });
}
