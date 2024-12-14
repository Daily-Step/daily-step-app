import 'package:dailystep/model/challenge/challenge_model.dart';

abstract class ChallengeListAction {
  const ChallengeListAction();
}

class AddTaskAction extends ChallengeListAction {
  final ChallengeModel challengeModel;

  const AddTaskAction(this.challengeModel);
}

class UpdateTaskAction extends ChallengeListAction {
  final id;
  final ChallengeModel challengeModel;

  const UpdateTaskAction(this.id, this.challengeModel);
}

class DeleteTaskAction extends ChallengeListAction {
  final int id;

  const DeleteTaskAction(this.id);
}

class FindTaskAction extends ChallengeListAction {
  final int id;

  const FindTaskAction(this.id);
}

