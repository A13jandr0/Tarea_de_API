import 'package:flutter/material.dart';
import '../models/user.dart';
import '../presenters/user_presenter.dart';
import 'user_view.dart';

class UserDeleteView extends StatefulWidget {
  final User user;

  const UserDeleteView({super.key, required this.user});

  @override
  State<UserDeleteView> createState() => _UserDeleteViewState();
}

class _UserDeleteViewState extends State<UserDeleteView>
    with SingleTickerProviderStateMixin
    implements UserView {
  late UserPresenter _presenter;
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _presenter = UserPresenter(this);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eliminar Usuario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFE74C3C),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9EBEA),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 80,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '¿Seguro que deseas eliminar este usuario?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.user.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF34495E),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              label: 'Cancelar',
                              color: Colors.grey,
                              icon: Icons.cancel_outlined,
                              onPressed: () => Navigator.pop(context),
                            ),
                            _buildActionButton(
                              label: 'Eliminar',
                              color: const Color(0xFFE74C3C),
                              icon: Icons.delete_outline,
                              onPressed: _deleteUser,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _deleteUser() {
    _presenter.deleteUser(widget.user.id!).then((_) {
      Navigator.pop(context); // Vuelve a la lista después de eliminar
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  void showLoading() {
    setState(() => _isLoading = true);
  }

  @override
  void showSuccess(String message) {
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void showError(String message) {
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void showUsers(List<User> users) {}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
