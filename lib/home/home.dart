import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/home/bloc/home_bloc.dart';
import 'package:todos/home/widgets/custom_textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
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

                      setState(() {});
                    }
                  : null,
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.fetchingState == FetchTodosState.progress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.fetchingState == FetchTodosState.error) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('$index'),
                      subtitle: Text(state.todos[index].title ?? ''),
                    );
                  },
                ),
              );
            },
          ),
        ],
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
