import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_moderation_state.dart';

class ReviewModerationCubit extends Cubit<ReviewModerationState> {
  ReviewModerationCubit() : super(ReviewModerationInitial());
}
