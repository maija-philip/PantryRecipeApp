import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pantry/basic_page.dart';
import 'dart:developer' as developer;


class AuthGate extends StatelessWidget {
 const AuthGate({super.key});

// final String userData;

 @override
 Widget build(BuildContext context) {
    final theme = Theme.of(context);

   return StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
      //userData = snapshot;
       if (!snapshot.hasData) {
         return SignInScreen(
           providerConfigs: const [
            EmailProviderConfiguration(),
           ],
           headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image.asset('assets/rice_bowl.png'),
                  ],
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Pantry, please sign in!')
                    : const Text('Welcome to Pantry, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }, 
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/rice_bowl.png'),
                ),
              );
            },
           
         );
       }
        else
        {
          //developer.log(snapshot.data!.uid);
          String userID = snapshot.data?.uid ?? "noData";
          return BasicPage(uid: userID, pageIndex: 1,);
        }
     },
   );
 }

}
