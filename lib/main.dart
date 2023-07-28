import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/addNote/note_cubit.dart';
import 'package:notes/cubit/deleteNote/delete_note_cubit.dart';
import 'package:notes/cubit/fetchNote/fetch_note_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/cubit/updateNote/note_update_cubit.dart';
import 'package:notes/screens/splash.dart';
import 'package:notes/services/NoteService.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<NoteService>(NoteService());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BlocDefine());
}

class BlocDefine extends StatelessWidget {
  const BlocDefine({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => NoteService())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NoteCubit()),
          BlocProvider(create: (context) => FetchNoteCubit()),
          BlocProvider(create: (context) => NoteUpdateCubit()),
          BlocProvider(create: (context) => DeleteNoteCubit()),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
