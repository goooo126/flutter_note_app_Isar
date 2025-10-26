import 'package:flutter/material.dart';
import 'package:note/Models/note_database.dart';
import 'package:note/Pages/notes_page.dart';
import 'package:note/Pages/settings_page.dart';
import 'package:note/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<NoteDatabase>(
          create: (context) => NoteDatabase(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/notesPage': (context) => const NotesPage(),
        '/settingsPage': (context) => const SettingsPage(),
      },
    );
  }
}
