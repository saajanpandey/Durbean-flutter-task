part of 'delete_note_cubit.dart';

abstract class DeleteNoteState extends Equatable {
  const DeleteNoteState();

  @override
  List<Object> get props => [];
}

class DeleteNoteInitial extends DeleteNoteState {}

class DeleteNoteFetched extends DeleteNoteState {}
