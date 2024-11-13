import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../model/challenge_record/challenge_record_model.dart';
import '../action/challenge_record_action.dart';

part 'challenge_record_viewmodel.g.dart';

@riverpod
class ChallengeRecordViewModel extends _$ChallengeRecordViewModel {
  late final List<ChallengeRecordModel> _initialRecords;

  ChallengesRecordState build() {
    _initialRecords = [];

    return ChallengesRecordState(
      recordList: _initialRecords,
      selectedRecord: null
    );
  }

  Future<void> handleAction(ChallengeRecordAction action) async {
    if (action is AddRecordAction) {
      _handleAddRecord(action);
    } else if (action is UpdateRecordAction) {
      _handleUpdateRecord(action);
    } else if (action is RemoveRecordAction) {
      await _handleRemoveRecord(action);
    } else if (action is FindRecordAction) {
      _handleFindRecord(action);
    }
  }

  void _handleAddRecord(AddRecordAction action) {
    final recordList = List<ChallengeRecordModel>.from(state.recordList);
    recordList.add(action.challengeRecordModel);

    state = state.copyWith(recordList:recordList);
  }

  void _handleUpdateRecord(UpdateRecordAction action) {
    final updatedTasks = state.recordList.map((task) {
      if (task.id == action.id) {
        return action.challengeRecordModel;
      }
      return task;
    }).toList();

    state = state.copyWith(recordList: updatedTasks);
  }

  Future<void> _handleRemoveRecord(RemoveRecordAction action) async {
    final tasks = List.of(state.recordList);
    tasks.removeWhere((task) => task.id == action.id);

    state = state.copyWith(
      recordList: tasks,
    );
  }

  Future<void> _handleFindRecord(FindRecordAction action) async {
    final records = List.of(state.recordList);
    final selectedRecord = records.firstWhere((task) => task.challengeId == action.id);
    state = state.copyWith(
      selectedRecord: selectedRecord,
    );
  }
}

class ChallengesRecordState {
  final List<ChallengeRecordModel> recordList;
  final ChallengeRecordModel? selectedRecord;

  const ChallengesRecordState({
    required this.recordList,
    this.selectedRecord,
  });

  ChallengesRecordState copyWith({
    List<ChallengeRecordModel>? recordList,
    ChallengeRecordModel? selectedRecord,
  }) {
    return ChallengesRecordState(
      recordList: recordList != null
          ? recordList
          : this.recordList,
      selectedRecord: selectedRecord ?? this.selectedRecord
    );
  }
}
