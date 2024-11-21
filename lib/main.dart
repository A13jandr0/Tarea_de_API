import 'package:flutter/material.dart';
import 'package:flutter_application_employee/models/user.dart';
import 'views/user_list_view.dart';
import 'views/user_create_view.dart';
import 'views/user_update_view.dart';
import 'views/user_delete_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Usuarios',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3949AB), // Indigo Dark
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF3949AB),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF34495E)), // Reemplaza bodyText1
          bodyMedium:
              TextStyle(color: Color(0xFF7F8C8D)), // Reemplaza bodyText2
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3949AB),
          ), // Reemplaza headline6
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF34495E),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFD5D8DC)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xFF3949AB), width: 2),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const UserListView(),
        '/create': (context) => const UserCreateView(),
        '/update': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          return UserUpdateView(user: user);
        },
        '/delete': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          return UserDeleteView(user: user);
        },
      },
    );
  }
}
