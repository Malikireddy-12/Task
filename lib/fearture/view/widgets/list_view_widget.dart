import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../bloc/task_view_model.dart';

class ListViewWidget extends StatelessWidget {
  final List<RowsData> model;
  const ListViewWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: model[index].imageHref,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              title: Text(model[index].title),
              subtitle: Text(model[index].description),
            ),
          ),
        );
      },
    );
  }
}
