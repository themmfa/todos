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

class DeleteTodo extends HomeEvent {
  const DeleteTodo({
    required this.index,
  });

  final int index;
}

class EditTodo extends HomeEvent {
  const EditTodo({
    required this.editedTodo,
    required this.index,
  });

  final String editedTodo;

  final int index;
}

class MarkAsComplete extends HomeEvent {
  const MarkAsComplete({
    required this.index,
  });

  final int index;
}
