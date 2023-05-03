part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.todos = const [],
  });

  HomeState copyWith({
    List<TodosModel>? todos,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
    );
  }

  final List<TodosModel> todos;

  @override
  List<Object?> get props => [todos];
}
