import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/main.dart';
import 'package:notes/services/NoteService.dart';

part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit() : super(DeleteNoteInitial());

  deleteNote(id) async {
    final response = await getIt<NoteService>().deleteNote(id);
    if (response) {
      emit(DeleteNoteFetched());
    }
  }
}
