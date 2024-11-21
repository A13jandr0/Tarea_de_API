import '../models/user.dart';

abstract class UserView {
  void showLoading();
  void showUsers(List<User> users);
  void showError(String message);
  void showSuccess(String message);
}
