class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;

  LoginState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
