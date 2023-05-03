import 'package:flutter/material.dart';
import 'package:todos/home/bloc/home_bloc.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.children,
    required this.state,
  });

  final TabController tabController;

  final List<Widget> children;

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Colors.blue,
              ),
              child: TabBar(
                controller: tabController,
                tabs: [
                  Tab(text: 'All: ${state.todos.length}'),
                  Tab(text: 'Completed: ${state.completedTodos.length}'),
                  Tab(text: "Sorted: ${state.sortedTodos.length}")
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
