import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/deleteNote/delete_note_cubit.dart';
import 'package:notes/cubit/updateNote/note_update_cubit.dart';
import 'package:notes/screens/notes.dart';

class EditNote extends StatefulWidget {
  final String? id;
  final String? title;
  final String? description;

  const EditNote({super.key, this.id, this.title, this.description});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _formKey = GlobalKey<FormState>();
  var title = TextEditingController();
  var note = TextEditingController();

  @override
  void initState() {
    title.text = widget.title!;
    note.text = widget.description!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotesPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.chevron_left_outlined,
              size: 40,
              color: Colors.amber,
            ),
          ),
          title: const Text(
            'Notes',
            style: TextStyle(color: Colors.amber),
          ),
          titleSpacing: -10,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    BlocProvider.of<NoteUpdateCubit>(context)
                        .updateNote(widget.id, title.text, note.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotesPage()),
                    );
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<DeleteNoteCubit>(context).deleteNote(widget.id);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const NotesPage(),
                    ),
                    (route) => false);
              },
              icon: const Icon(
                Icons.delete_outlined,
                color: Colors.amber,
                size: 30,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter your title here:',
                      labelText: 'Title',
                    ),
                    controller: title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The title field is required.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 450,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter your notes here:',
                        labelText: 'Note',
                      ),
                      controller: note,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The note field is required.";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
