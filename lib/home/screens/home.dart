import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/model/todos_model.dart';
import 'package:todos/home/bloc/home_bloc.dart';
import 'package:todos/home/widgets/custom_tab_bar.dart';
import 'package:todos/home/widgets/custom_textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();

  final TextEditingController dialogTextEditingController =
      TextEditingController();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });

    dialogTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    dialogTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODOS"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _AddTodo(
              controller: controller,
              onPressed: controller.text != ''
                  ? () {
                      context
                          .read<HomeBloc>()
                          .add(AddTodo(newTodo: controller.text));

                      setState(() {
                        controller.clear();
                      });
                    }
                  : null,
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.fetchingState == FetchTodosState.progress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.fetchingState == FetchTodosState.error) {
                return const Center(
                  child: Text("Something went wrong while fetching the data"),
                );
              }
              return CustomTabBar(
                state: state,
                tabController: tabController,
                children: [
                  CustomListView(
                    todos: state.todos,
                    dialogTextEditingController: dialogTextEditingController,
                  ),
                  CustomListView(
                    todos: state.completedTodos,
                    dialogTextEditingController: dialogTextEditingController,
                  ),
                  CustomListView(
                    todos: state.sortedTodos,
                    dialogTextEditingController: dialogTextEditingController,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.todos,
    this.dialogTextEditingController,
  });

  final List<TodosModel> todos;

  final TextEditingController? dialogTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('$index'),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text('${todos[index].title}')),
                  IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(DeleteTodo(index: index));
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text('Edit'),
                            content: CustomTextField(
                              hintText: 'Edit your todo',
                              controller: dialogTextEditingController!,
                            ),
                            actions: [
                              ElevatedButton(
                                child: const Text('Edit'),
                                onPressed: () {
                                  context.read<HomeBloc>().add(EditTodo(
                                        editedTodo:
                                            dialogTextEditingController!.text,
                                        index: index,
                                      ));
                                  Navigator.pop(
                                    context,
                                  );
                                  dialogTextEditingController!.clear();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  if (todos[index].completed != true)
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.done),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AddTodo extends StatelessWidget {
  const _AddTodo({
    required this.controller,
    this.onPressed,
  });

  final TextEditingController controller;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: 'Enter the task you want to add',
            controller: controller,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            'Add Todo',
          ),
        ),
      ],
    );
  }
}
