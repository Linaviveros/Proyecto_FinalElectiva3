import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/cartelera_screen.dart';
import 'providers/cartelera_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarteleraProvider()),
      ],
      child: MaterialApp(
        title: 'Cinema App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black87),
            titleTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const CarteleraScreen(),
      ),
    );
  }
}


