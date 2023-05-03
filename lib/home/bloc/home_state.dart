part of 'home_bloc.dart';

enum FetchTodosState {
  error,
  completed,
  progress,
}

class HomeState extends Equatable {
  const HomeState({
    this.todos = const [],
    this.fetchingState = FetchTodosState.progress,
  });

  HomeState copyWith({
    List<TodosModel>? todos,
    FetchTodosState? fetchingState,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
      fetchingState: fetchingState ?? this.fetchingState,
    );
  }

  final List<TodosModel> todos;

  final FetchTodosState fetchingState;

  @override
  List<Object?> get props => [todos, fetchingState];
}
