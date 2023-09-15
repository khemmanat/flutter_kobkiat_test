import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kobkiat_test/common/constants/app_colors.dart';
import 'package:flutter_kobkiat_test/presentation/features/home/bloc/task_bloc.dart';
import 'package:flutter_kobkiat_test/presentation/widgets/app_scaffold_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/task_data.dart';
import 'widgets/task_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskBloc = TaskBloc();
  TextEditingController titleController = TextEditingController();

  void addTask() {
    if (titleController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Please enter your task',
                    style: TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK')),
                      ),
                    ],
                  )
                ],
              )));
    } else {
      const uuid = Uuid();
      taskBloc.add(AddTask(task: TaskData(id: uuid.v1(), title: titleController.text, complete: false)));
      titleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: AppScaffoldView(
        backgroundColor: AppColors.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColors.primaryGreen,
          title: const Text('Todo List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.primaryWhite,
              )),
          actions: [
            IconButton(
              onPressed: () {
                showAddTaskDialog();
              },
              icon: const Icon(
                Icons.add,
                color: AppColors.primaryWhite,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your task',
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primaryGray),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) return;
                            addTask();
                          }),
                    ),
                    InkWell(
                      onTap: () {
                        addTask();
                      },
                      child: Container(
                        height: double.infinity,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.check, color: AppColors.primaryWhite),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<TaskBloc, TaskState>(
                bloc: taskBloc..add(const FetchTask()),
                buildWhen: (previous, current) {
                  return previous.taskList != current.taskList;
                },
                builder: (BuildContext context, TaskState state) {
                  log('check state :: $state');
                  if (state.taskList.isEmpty) {
                    return Expanded(
                      child: SizedBox(
                        height: 300.h,
                        child: const Text('Empty Tasks'),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = state.taskList[index];
                      return TaskCardWidget(
                        task: task,
                        onChanged: (value) {
                          taskBloc.add(UpdateTask(task: TaskData(id: task.id, title: task.title, complete: value)));
                        },
                        onDelete: () {
                          taskBloc.add(DeleteTask(task: task));
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // optional for using dialog to add task
  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Enter your task',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryGray),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addTask();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

//to-do list
