import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Center(
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
                            icon: Image.asset("assets/google.png",
                                width: 32, height: 32),
                          ),
                        ],
                      )
                    : Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                "Vacuna Card",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              const Text.rich(
                                TextSpan(
                                  text:
                                      "Registrate en nuestra aplicación usando \n",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: "Google account",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              const CircleAvatar(
                                maxRadius: 50,
                                minRadius: 50,
                                backgroundImage:
                                    AssetImage('assets/profile.png'),
                                backgroundColor: Colors.transparent,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Iniciar Sesión",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 25),
                              ),
                              const SizedBox(height: 20),
                              FloatingActionButton.extended(
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
                                icon: Image.asset("assets/google.png",
                                    width: 32, height: 32),
                              ),
                              const SizedBox(height: 20),
                              const Divider(
                                height: 20,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.black12,
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () async {
                                    const url = "https://flutter.io";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw "Could not launch $url";
                                    }
                                  },
                                  child: const Text(
                                    "Politicas de privacidad",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
