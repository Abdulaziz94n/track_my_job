import 'package:flutter/material.dart';

import 'notes_list.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: const NotesList(),
    );
  }
}
