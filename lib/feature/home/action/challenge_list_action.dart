import 'package:flutter/cupertino.dart';

abstract class ChallengeListAction {
  const ChallengeListAction();
}

class AddChallengeAction extends ChallengeListAction {
  final Map<String,dynamic> data;
  final BuildContext context;

  const AddChallengeAction(this.data, this.context);
}

class UpdateChallengeAction extends ChallengeListAction {
  final id;
  final Map<String,dynamic> data;

  const UpdateChallengeAction(this.id, this.data);
}

class AchieveChallengeAction extends ChallengeListAction {
  final id;
  final BuildContext context;
  final bool isCancel;

  const AchieveChallengeAction(
      {required this.id,
      required this.context,
      required this.isCancel});
}

class DeleteChallengeAction extends ChallengeListAction {
  final int id;
  final BuildContext context;

  const DeleteChallengeAction(this.id, this.context);
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

