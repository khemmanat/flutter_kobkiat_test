import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../domain/entities/task_data.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({super.key, required this.task, required this.onChanged, required this.onDelete});

  final TaskData task;
  final Function(bool) onChanged;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        border: Border.all(color: AppColors.primaryGray),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryWhite.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: task.complete,
            onChanged: (value) {
              onChanged(value!);
            },
          ),
          Text(
            task.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          IconButton(
            onPressed: () {
              onDelete();
            },
            icon: const Icon(Icons.delete_forever, color: AppColors.primaryRed),
          ),
        ],
      ),
    );
  }
}
