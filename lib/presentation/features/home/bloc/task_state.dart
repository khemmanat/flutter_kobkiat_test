part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({
    this.taskList = const <TaskData>[],
  });

  final List<TaskData> taskList;

  TaskState copyWith({
    List<TaskData>? taskList,
  }) {
    return TaskState(
      taskList: taskList ?? this.taskList,
    );
  }

  @override
  List<Object> get props => [taskList];
}
