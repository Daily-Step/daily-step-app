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
  NickNameProvider(this.ref) : super(NickNameState(nickName: '', isValid: false));

  final Ref ref;

  bool _validateNickName(String nickName) {
    return nickName.isNotEmpty;
  }

  void updateNickName(String nickName) {
    bool isValid = _validateNickName(nickName);
    if (nickName != state.nickName || isValid != state.isValid) {
      state = state.copyWith(nickName: nickName, isValid: isValid);
      // 유효성 상태를 갱신
      ref.read(isNickNameValidProvider.notifier).state = isValid;
    }
  }
}

final isNickNameValidProvider = StateProvider<bool>((ref) => false);

final nickNameProvider = StateNotifierProvider<NickNameProvider, NickNameState>(
      (ref) => NickNameProvider(ref),
);
