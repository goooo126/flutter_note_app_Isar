import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/Models/note.dart';
import 'package:note/Models/note_database.dart';
import 'package:note/components/drawer.dart';
import 'package:note/components/note_tile.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  // text field controller
  final textController = TextEditingController();

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Type you note...',
            ),
          ),
          actions: [
            // create button
            MaterialButton(
              onPressed: () {
                // create note into data base
                context.read<NoteDatabase>().addNote(textController.text);
                textController.clear();
                // pop the alert dialog
                Navigator.pop(context);
              },
              textColor: Colors.green,
              child: const Text('Create'),
            ),
            // cancel button
            MaterialButton(
              onPressed: () {
                // pop the alert dialog
                Navigator.pop(context);
              },
              textColor: Colors.red,
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // read all notes
  void readNotes() {
    context.read<NoteDatabase>().getAllNotes();
  }

  // update a note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Note"),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            // create button
            MaterialButton(
              onPressed: () {
                // create note into data base
                context
                    .read<NoteDatabase>()
                    .updateNote(note.id, textController.text);
                textController.clear();
                // pop the alert dialog
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // delete a note
  void deleteNote(Note note) {
    context.read<NoteDatabase>().deleteNote(note.id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> notes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // list of notes
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteTile(
                  text: note.text,
                  deleteNote: () => deleteNote(note),
                  updateNote: () => updateNote(note),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
