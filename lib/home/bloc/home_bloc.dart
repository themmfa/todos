import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/model/todos_model.dart';
import 'package:todos/data/repository/todos_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInit>(_onHomeInit);
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
      ));
    } catch (e) {
      // TODO(ferdogan): add error handling
      print(e);
    }
  }
}
