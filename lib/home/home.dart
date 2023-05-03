import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/home/bloc/home_bloc.dart';
import 'package:todos/home/widgets/custom_textfield.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const HomeInit());
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
              onPressed: controller.text != '' ? () {} : null,
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final todos = state.todos;
              return Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${state.todos[index].id}'),
                      subtitle: Text(state.todos[index].title ?? ''),
                    );
                  },
                ),
              );
            },
          )
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
