import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/model/todos_model.dart';
import 'package:todos/data/repository/todos_repository.dart';
import 'package:todos/home/utils/utils.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInit>(_onHomeInit);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<EditTodo>(_onEditTodo);
    on<MarkAsComplete>(_onMarkAsComplete);
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

  Future<void> _onDeleteTodo(
    DeleteTodo event,
    Emitter<HomeState> emit,
  ) async {
    state.todos.removeAt(event.index);

    emit(state.copyWith(
      todos: state.todos,
      completedTodos: completedTodos(state.todos),
      sortedTodos: sortedByTitle(state.todos),
    ));
  }

  Future<void> _onEditTodo(
    EditTodo event,
    Emitter<HomeState> emit,
  ) async {
    final index = event.index;
    final text = event.editedTodo;

    state.todos[index].title = text;

    emit(state.copyWith(
      todos: state.todos,
      completedTodos: completedTodos(state.todos),
      sortedTodos: sortedByTitle(state.todos),
    ));
  }

  Future<void> _onMarkAsComplete(
    MarkAsComplete event,
    Emitter<HomeState> emit,
  ) async {
    state.todos[event.index].completed = true;

    emit(state.copyWith(
      todos: state.todos,
      completedTodos: completedTodos(state.todos),
    ));
  }
}
