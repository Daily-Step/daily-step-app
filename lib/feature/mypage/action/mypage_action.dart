abstract class MyPageAction {}

class FetchUserDataAction extends MyPageAction {}
class UpdateUserProfileAction extends MyPageAction {
  final String newUserName;
  final DateTime birth;
  final String gender;

  UpdateUserProfileAction(this.newUserName, this.birth, this.gender);
}
class TogglePushNotificationAction extends MyPageAction {}

mixin EventMixin<T> {
  void handleEvent(T event);
}