import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/main.dart';
import 'package:notes/services/NoteService.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  saveNote(title, note) async {
    // emit(NoteSending());

    final response = await getIt<NoteService>().saveNote(title, note);

    if (response) {
      emit(NoteSuccess());
    } else {
      emit(NoteError());
    }
  }
}
