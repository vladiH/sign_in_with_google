import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  GoogleSignInAccount? userData;
  GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoggedIn
            ? Column(
                children: [
                  CircleAvatar(
                    child: Image.network(userData?.photoUrl ?? ""),
                    maxRadius: 200,
                    minRadius: 200,
                  ),
                  Text(userData?.displayName ?? "displayName"),
                  Text(userData?.email ?? "email"),
                  Text(userData?.id ?? "id"),
                  Text(userData?.serverAuthCode ?? "serverAuthCode"),
                  FloatingActionButton.extended(
                    onPressed: () {
                      googleSignIn.signOut().then((value) {
                        setState(() {
                          isLoggedIn = false;
                        });
                      });
                    },
                    label: const Text("Log out"),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    icon:
                        Image.asset("assets/google.png", width: 32, height: 32),
                  ),
                ],
              )
            : FloatingActionButton.extended(
                onPressed: () {
                  googleSignIn.signIn().then((value) {
                    setState(() {
                      isLoggedIn = true;
                      userData = value;
                    });
                  });
                },
                label: const Text("Sign in with Google"),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                icon: Image.asset("assets/google.png", width: 32, height: 32),
              ),
      ),
    );
  }
}
