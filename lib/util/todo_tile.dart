import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?) onCheckBoxChanged;
  Function(DismissDirection)? onTaskDeleted;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onCheckBoxChanged,
    required this.onTaskDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Dismissible(
        background: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
              ),
              Icon(Icons.archive),
            ],
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: Colors.red.shade400,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete),
              SizedBox(
                width: 24,
              )
            ],
          ),
        ),
        key: Key(taskName),
        onDismissed: onTaskDeleted,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTileTheme(
            data: const ListTileThemeData(
              horizontalTitleGap: 0,
            ),
            child: CheckboxListTile(
              activeColor: Colors.black,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              value: taskCompleted,
              onChanged: onCheckBoxChanged,
            ),
          ),
        ),
      ),
    );
  }
}
