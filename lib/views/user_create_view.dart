import 'package:flutter/material.dart';
import '../models/user.dart';
import '../presenters/user_presenter.dart';
import 'user_view.dart';

class UserCreateView extends StatefulWidget {
  const UserCreateView({super.key});

  @override
  State<UserCreateView> createState() => _UserCreateViewState();
}

class _UserCreateViewState extends State<UserCreateView>
    with SingleTickerProviderStateMixin
    implements UserView {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _gender = 'male';
  String _status = 'active';
  late UserPresenter _presenter;
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
    _presenter = UserPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Crear Usuario', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF4F6F7),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ScaleTransition(
              scale: _scaleAnimation,
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
                        _buildInputField(
                          label: 'Nombre',
                          controller: _nameController,
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        _buildInputField(
                          label: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 15),
                        _buildGenderField(),
                        const SizedBox(height: 15),
                        _buildStatusField(),
                        const SizedBox(height: 20),
                        _buildCreateButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF2C3E50)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF2C3E50), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildGenderField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(
              Icons.person_outline,
              color: const Color(0xFF2C3E50),
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _gender,
                hint: const Text('Género'),
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'male',
                    child: Row(
                      children: [
                        Icon(Icons.male, color: Colors.blue[700]),
                        const SizedBox(width: 10),
                        Text('Masculino',
                            style: TextStyle(color: Colors.blue[700])),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'female',
                    child: Row(
                      children: [
                        Icon(Icons.female, color: Colors.pink[700]),
                        const SizedBox(width: 10),
                        Text('Femenino',
                            style: TextStyle(color: Colors.pink[700])),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) => setState(() => _gender = value!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(
              Icons.check_circle_outline,
              color: const Color(0xFF2C3E50),
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _status,
                hint: const Text('Estado'),
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'active',
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green[700]),
                        const SizedBox(width: 10),
                        Text('Activo',
                            style: TextStyle(color: Colors.green[700])),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'inactive',
                    child: Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.red[700]),
                        const SizedBox(width: 10),
                        Text('Inactivo',
                            style: TextStyle(color: Colors.red[700])),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) => setState(() => _status = value!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton(
      onPressed: _createUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2C3E50),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      child: const Text(
        'Crear Usuario',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _createUser() {
    final user = User(
      name: _nameController.text,
      email: _emailController.text,
      gender: _gender,
      status: _status,
    );

    _presenter.createUser(user).then((_) {
      Navigator.pop(context);
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
