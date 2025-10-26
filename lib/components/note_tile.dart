import 'package:flutter/material.dart';
import 'package:note/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? deleteNote;
  final void Function()? updateNote;
  const NoteTile({
    super.key,
    required this.text,
    required this.deleteNote,
    required this.updateNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: ListTile(
        title: Text(
          text,
        ),
        trailing: Builder(builder: (context) {
          return IconButton(
            onPressed: () => showPopover(
              height: 100,
              width: 100,
              backgroundColor: Theme.of(context).colorScheme.surface,
              context: context,
              bodyBuilder: (context) => NoteSettings(
                onDelete: deleteNote,
                onUpdate: updateNote,
              ),
            ),
            icon: const Icon(Icons.more_vert),
          );
        }),
      ),
    );
  }
}
