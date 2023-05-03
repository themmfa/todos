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

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
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
                  CustomListView(todos: state.todos),
                  CustomListView(todos: state.completedTodos),
                  CustomListView(todos: state.sortedTodos),
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
  });

  final List<TodosModel> todos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${index + 1}'),
            subtitle: Text(todos[index].title ?? ''),
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
