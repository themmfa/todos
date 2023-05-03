part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInit extends HomeEvent {
  const HomeInit();
}

class AddTodo extends HomeEvent {
  const AddTodo({
    required this.newTodo,
  });

  /// New todo text
  final String newTodo;
}
