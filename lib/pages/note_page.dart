import 'package:flutter/material.dart';
import 'package:vanzara/database/note_database.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key}); // fixed: constructor name must match class

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes(); // fixed: actually load the notes
  }

  Future<void> fetchNotes() async {
    final fetchedNotes = await getNotes(); // renamed local var to avoid clash
    setState(() {
      notes = fetchedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fixed line 22: added `return`
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Notes'), // fixed line 26: no widget.title exists
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black26),
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notes, size: 80, color: Colors.grey[600]),
                  const SizedBox(height: 20),
                  Text(
                    'No notes found.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600], // fixed: was Colors.grey[6]
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16, // fixed: 0.85 was too small
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Text(note['title']?.toString() ?? '');
                },
              ),
            ),
    ); // fixed: closing parenthesis for Scaffold
  }
}
