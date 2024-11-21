import '../services/api_service.dart';
import '../models/user.dart';
import '../views/user_view.dart';

class UserPresenter {
  final UserView _view;
  final ApiService _apiService;

  UserPresenter(this._view) : _apiService = ApiService();

  Future<void> loadUsers() async {
    try {
      _view.showLoading();
      final users = await _apiService.getUsers();
      _view.showUsers(users);
    } catch (e) {
      _view.showError(e.toString());
    }
  }

  Future<void> createUser(User user) async {
    try {
      _view.showLoading();
      await _apiService.createUser(user);
      _view.showSuccess('Usuario creado exitosamente');
    } catch (e) {
      _view.showError(e.toString());
    }
  }

  Future<void> updateUser(int id, User user) async {
    try {
      _view.showLoading();
      await _apiService.updateUser(id, user);
      _view.showSuccess('Usuario actualizado exitosamente');
    } catch (e) {
      _view.showError(e.toString());
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      _view.showLoading();
      await _apiService.deleteUser(id);
      _view.showSuccess('Usuario eliminado exitosamente');
    } catch (e) {
      _view.showError(e.toString());
    }
  }
}
