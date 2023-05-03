import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/model/todos_model.dart';
import 'package:todos/data/repository/todos_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInit>(_onHomeInit);
    on<AddTodo>(_onAddTodo);
  }

  Future<void> _onHomeInit(
    HomeInit event,
    Emitter<HomeState> emit,
  ) async {
    final todosRepository = TodosRepository();
    final todosList = <TodosModel>[];

    try {
      final todosResponse = await todosRepository.fetchTodos();
      for (var todo in todosResponse) {
        todosList.add(TodosModel.fromJson(todo));
      }
      emit(state.copyWith(
        todos: todosList,
        completedTodos: completedTodos(todosList),
        sortedTodos: sortedByTitle(todosList),
        fetchingState: FetchTodosState.completed,
      ));
    } catch (e) {
      emit(state.copyWith(
        fetchingState: FetchTodosState.error,
      ));
    }
  }

  Future<void> _onAddTodo(
    AddTodo event,
    Emitter<HomeState> emit,
  ) async {
    final newTodo = TodosModel(title: event.newTodo, completed: false);
    state.todos.insert(0, newTodo);
    emit(state.copyWith(
      todos: state.todos,
      completedTodos: completedTodos(state.todos),
      sortedTodos: sortedByTitle(state.todos),
    ));
  }

  /// return completed todos
  List<TodosModel> completedTodos(List<TodosModel> todos) {
    final completed = <TodosModel>[];
    for (var todo in todos) {
      if (todo.completed == true) {
        completed.add(todo);
      }
    }
    return completed;
  }

  /// return sorted todos by title
  List<TodosModel> sortedByTitle(List<TodosModel> todos) {
    final sortedTodos = [...todos];
    sortedTodos.sort((a, b) => a.title!.compareTo(b.title!));
    return sortedTodos;
  }
}
