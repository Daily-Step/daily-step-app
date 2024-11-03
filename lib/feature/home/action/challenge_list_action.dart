abstract class ChallengeListAction {
  const ChallengeListAction();
}

class ReorderTasksAction extends ChallengeListAction {
  final int oldIndex;
  final int newIndex;

  const ReorderTasksAction(this.oldIndex, this.newIndex);
}

class RemoveTaskAction extends ChallengeListAction {
  final int id;

  const RemoveTaskAction(this.id);
}

class FindTaskAction extends ChallengeListAction {
  final int id;

  const FindTaskAction(this.id);
}

