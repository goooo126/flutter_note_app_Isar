import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onDelete;
  final void Function()? onUpdate;
  const NoteSettings({
    super.key,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDelete!();
          },
          child: Container(
            width: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onUpdate!();
          },
          child: Center(
            child: Container(
              height: 50,
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
