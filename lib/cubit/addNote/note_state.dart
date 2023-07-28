part of 'note_cubit.dart';

@immutable
abstract class NoteState extends Equatable {
  const NoteState();
  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteSending extends NoteState {}

class NoteSuccess extends NoteState {
  // final FeedbackModal feedbackModal;
  // FeedbackSuccess({required this.feedbackModal});
}

class NoteError extends NoteState {
  // final FeedbackModal feedbackModal;
  // FeedbackError({required this.feedbackModal});
}
