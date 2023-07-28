import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/main.dart';
import 'package:notes/modal/NoteModal.dart';
import 'package:notes/services/NoteService.dart';

part 'fetch_note_state.dart';

class FetchNoteCubit extends Cubit<FetchNoteState> {
  FetchNoteCubit() : super(FetchNoteInitial());

  fetchNote() async {
    try {
      final response = await getIt<NoteService>().getTodos();
      if (response?.length != 0) {
        if (response != null) {
          emit(FetchNoteFetched(noteData: response));
        }
      }
    } catch (e) {
      emit(FetchNoteError());
    }
  }
}
