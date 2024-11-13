import '../../../model/challenge_record/challenge_record_model.dart';

abstract class ChallengeRecordAction {
  const ChallengeRecordAction();
}

class AddRecordAction extends ChallengeRecordAction {
  final ChallengeRecordModel challengeRecordModel;

  const AddRecordAction(this.challengeRecordModel);
}

class UpdateRecordAction extends ChallengeRecordAction {
  final id;
  final ChallengeRecordModel challengeRecordModel;

  const UpdateRecordAction(this.id, this.challengeRecordModel);
}

class RemoveRecordAction extends ChallengeRecordAction {
  final int id;

  const RemoveRecordAction(this.id);
}

class FindRecordAction extends ChallengeRecordAction {
  final int id;

  const FindRecordAction(this.id);
}

