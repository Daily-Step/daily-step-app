import 'package:flutter_riverpod/flutter_riverpod.dart';

class NickNameState {
  final String nickName;
  final bool isValid;

  NickNameState({required this.nickName, required this.isValid});

  NickNameState copyWith({String? nickName, bool? isValid}) {
    return NickNameState(
      nickName: nickName ?? this.nickName,
      isValid: isValid ?? this.isValid,
    );
  }
}

class NickNameProvider extends StateNotifier<NickNameState> {
  NickNameProvider() : super(NickNameState(nickName: '', isValid: false));

  bool _validateNickName(String nickName) {
    return nickName.isNotEmpty;
  }

  void updateNickName(String nickName) {
    bool isValid = nickName.isNotEmpty;
    if (nickName != state.nickName || isValid != state.isValid) {
      state = state.copyWith(nickName: nickName, isValid: isValid);
    }
  }
}

final nickNameProvider =
StateNotifierProvider<NickNameProvider, NickNameState>(
      (ref) => NickNameProvider(),
);
