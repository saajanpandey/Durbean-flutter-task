import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/addNote/note_cubit.dart';
import 'package:notes/screens/notes.dart';
import 'package:notes/services/StorageService.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  void initState() {
    super.initState();
    setApplicationStatus();
  }

  setApplicationStatus() async {
    await StorageService().setApplicationStatus(true);
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var note = TextEditingController();
  var title = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const Drawer(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const NotesPage(),
                  ),
                  (route) => false);
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
                    BlocProvider.of<NoteCubit>(context)
                        .saveNote(title.text, note.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
