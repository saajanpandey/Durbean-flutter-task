import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/main.dart';
import 'package:notes/services/NoteService.dart';

part 'note_update_state.dart';

class NoteUpdateCubit extends Cubit<NoteUpdateState> {
  NoteUpdateCubit() : super(NoteUpdateInitial());

  updateNote(id, title, note) async {
    await getIt<NoteService>().updateTodo(id, title, note);
  }
}
