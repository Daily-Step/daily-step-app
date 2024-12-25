import 'package:dailystep/model/challenge/challenge_model.dart';
import 'package:flutter/cupertino.dart';

abstract class ChallengeListAction {
  const ChallengeListAction();
}

class AddChallengeAction extends ChallengeListAction {
  final ChallengeModel challengeModel;

  const AddChallengeAction(this.challengeModel);
}

class UpdateChallengeAction extends ChallengeListAction {
  final id;
  final ChallengeModel challengeModel;

  const UpdateChallengeAction(this.id, this.challengeModel);
}

class AchieveChallengeAction extends ChallengeListAction {
  final id;
  final ChallengeModel challengeModel;
  final BuildContext context;
  final bool isCancel;

  const AchieveChallengeAction(
      {required this.id,
      required this.challengeModel,
      required this.context,
      required this.isCancel});
}

class DeleteChallengeAction extends ChallengeListAction {
  final int id;

  const DeleteChallengeAction(this.id);
}

class FindChallengeAction extends ChallengeListAction {
  final int id;

  const FindChallengeAction(this.id);
}

class ChangeSelectedDateAction extends ChallengeListAction {
  final DateTime selectedDate;
  const ChangeSelectedDateAction({required this.selectedDate});
}

class ChangeFirstDateOfWeekAction extends ChallengeListAction {
  final int? addPage;

  const ChangeFirstDateOfWeekAction({this.addPage});
}

