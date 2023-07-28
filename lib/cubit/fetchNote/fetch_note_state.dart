part of 'fetch_note_cubit.dart';

abstract class FetchNoteState extends Equatable {
  const FetchNoteState();

  @override
  List<Object> get props => [];
}

class FetchNoteInitial extends FetchNoteState {}

class FetchNoteFetching extends FetchNoteState {}

class FetchNoteFetched extends FetchNoteState {
  final List<TodoModal> noteData;
  FetchNoteFetched({required this.noteData});
  @override
  List<Object> get props => [noteData];
}

class FetchNoteError extends FetchNoteState {}
