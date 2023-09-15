//task bloc test
import 'package:flutter_kobkiat_test/domain/entities/task_data.dart';
import 'package:flutter_kobkiat_test/presentation/features/home/bloc/task_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('TaskBloc', () {
    late TaskBloc taskBloc;

    setUp(() {
      taskBloc = TaskBloc();
    });

    test('initial state is TaskState', () {
      expect(taskBloc.state, TaskState());
    });

    test('FetchTask event', () {
      const uuid = Uuid();
      final state = TaskState(taskList: []);
      taskBloc.add(FetchTask());
      final lastState = taskBloc.state;
      expect(lastState.taskList, state.taskList);
    });

    test('AddTask event', () {
      const uuid = Uuid();
      final task = TaskData(id: uuid.v1(), title: 'title', complete: false);
      final state = TaskState(taskList: [task]);
      taskBloc.add(AddTask(task: task));
      final lastState = taskBloc.state;
      expect(lastState.taskList, state.taskList);
    });

    test('UpdateTask event', () {
      const uuid = Uuid();
      final task = TaskData(id: uuid.v1(), title: 'title', complete: false);
      final state = TaskState(taskList: [task]);
      taskBloc.add(UpdateTask(task: task));
      final lastState = taskBloc.state;
      expect(lastState.taskList, state.taskList);
    });

    test('DeleteTask event', () {
      const uuid = Uuid();
      final task = TaskData(id: uuid.v1(), title: 'title', complete: false);
      final state = TaskState(taskList: [task]);
      taskBloc.add(DeleteTask(task: task));
      final lastState = taskBloc.state;
      expect(lastState.taskList, state.taskList);
    });
  });
}
