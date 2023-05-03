part of 'home_bloc.dart';

enum FetchTodosState {
  error,
  completed,
  progress,
}

class HomeState extends Equatable {
  const HomeState({
    this.todos = const [],
    this.completedTodos = const [],
    this.sortedTodos = const [],
    this.fetchingState = FetchTodosState.progress,
  });

  HomeState copyWith({
    List<TodosModel>? todos,
    List<TodosModel>? completedTodos,
    List<TodosModel>? sortedTodos,
    FetchTodosState? fetchingState,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
      completedTodos: completedTodos ?? this.completedTodos,
      sortedTodos: sortedTodos ?? this.sortedTodos,
      fetchingState: fetchingState ?? this.fetchingState,
    );
  }

  final List<TodosModel> todos;

  final List<TodosModel> completedTodos;

  final List<TodosModel> sortedTodos;

  final FetchTodosState fetchingState;

  @override
  List<Object?> get props =>
      [todos, completedTodos, sortedTodos, fetchingState];
}
