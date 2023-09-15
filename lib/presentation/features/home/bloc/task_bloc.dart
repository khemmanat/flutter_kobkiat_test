import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/task_data.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<FetchTask>(_onFetchTask);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onFetchTask(FetchTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(state.copyWith(taskList: state.taskList));
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(state.copyWith(taskList: [...state.taskList, event.task]));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final tasks = state.taskList.map((task) {
      if (task.id == event.task.id) {
        return event.task;
      }
      return task;
    }).toList();
    emit(state.copyWith(taskList: tasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final tasks = state.taskList.where((task) => task.id != event.task.id).toList();
    emit(state.copyWith(taskList: tasks));
  }
}
