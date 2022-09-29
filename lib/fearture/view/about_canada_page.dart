import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/error_handler_enum.dart';
import '../../common/loading.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_state.dart';
import 'widgets/list_view_widget.dart';

class AboutCanadaPage extends StatefulWidget {
  const AboutCanadaPage({Key? key}) : super(key: key);

  @override
  State<AboutCanadaPage> createState() => _AboutCanadaPageState();
}

class _AboutCanadaPageState extends State<AboutCanadaPage> {
  TextEditingController editingController = TextEditingController();
  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()..getResultsApi(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About Canada'),
        ),
        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state.error.errorCode == ErrorHandlerEnum.Error_401) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error.description),
                  ),
                );
              }
            },
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state.loader == const LoadingIndicatorViewModel.loading()) {
                  context.read<TaskBloc>().getResultsApi();
                  return const Center(child: CircularProgressIndicator());
                } else if (state.loader ==
                    const LoadingIndicatorViewModel.loaded()) {
                  return RefreshIndicator(
                    color: Colors.black,
                    strokeWidth: 4.0,
                    onRefresh: () async {
                      context.read<TaskBloc>().getResultsApi();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<TaskBloc>()
                                  .filterSearchResults(value, state.taskModel);
                            },
                            controller: editingController,
                            decoration: const InputDecoration(
                                labelText: "Search",
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0)))),
                          ),
                        ),
                        Expanded(
                          child: ListViewWidget(
                            model: state.taskModel.filtered,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.error.errorCode ==
                    ErrorHandlerEnum.Error_401) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
