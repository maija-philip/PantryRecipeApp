import 'package:flutter/material.dart';
import 'basic_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_auth/firebase_options.dart';
import 'firebase_auth/auth_gate.dart';



Future<void> main() async {
  // firebase stuff
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pantry',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(33, 92, 186, 0)),
          textTheme: const TextTheme(
            displayMedium: TextStyle(fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(fontWeight: FontWeight.bold),
          )
        ),
        home: const AuthGate(),
      );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pantry", style: theme.textTheme.displayLarge,),
                  Image.asset('assets/rice_bowl.png'),
                  FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AuthGate())
                            );
                          },
                          child: const Text('Continue'),
                        ),
                ],
              ),
            ),
          ),
    );
  }
}

