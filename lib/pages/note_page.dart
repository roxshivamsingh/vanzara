import 'package:flutter/material.dart';
import 'package:vanzara/database/note_database.dart';

class NotePage extends StatefulWidget {
  const new({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Map<String, dynamic>> notes = [];

  Future<void> fetchNotes() async {
    final fetchNotes = await getNotes();
    setState(() {
      notes = fetchNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notes, size: 80, color: Colors.grey[600]),
                SizedBox(height: 20),
                Text(
                  'No notes found.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[6],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        : Column(children: []);
  }
}
