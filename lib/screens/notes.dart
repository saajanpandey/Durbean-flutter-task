import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/fetchNote/fetch_note_cubit.dart';
import 'package:notes/screens/editNote.dart';
import 'package:notes/screens/home.dart';
import 'package:notes/screens/search.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    BlocProvider.of<FetchNoteCubit>(context).fetchNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePage(),
              ),
            );
          },
          icon: const Icon(
            Icons.note_add_outlined,
            size: 45,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: BlocBuilder<FetchNoteCubit, FetchNoteState>(
          builder: (context, state) {
            if (state is FetchNoteFetched) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0, left: 25),
                              child: Text(
                                'Notes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey,
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListTile(
                                leading: const Icon(Icons.search),
                                title: const Text('Search'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SearchPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(top: 5, left: 10),
                              itemCount: state.noteData.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditNote(
                                          id: '${state.noteData[index].id}',
                                          title:
                                              '${state.noteData[index].title}',
                                          description:
                                              ' ${state.noteData[index].description}',
                                        ),
                                      ),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.only(
                                      left: 25, right: 25),
                                  title: Text(
                                    '${state.noteData[index].title}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${state.noteData[index].description}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      '${state.noteData.length} Note',
                    ),
                  )
                ],
              );
            } else {
              return const SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, left: 20),
                        child: Text(
                          'Notes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                    Text('No Notes Found!'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
