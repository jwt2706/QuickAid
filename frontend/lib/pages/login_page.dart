import 'package:flutter/material.dart';

import 'package:auth0_flutter/auth0_flutter.dart'; 
const appScheme = 'quickaid';

/// -----------------------------------
///           Profile Widget           
/// -----------------------------------
class Profile extends StatelessWidget {
  final Future<void> Function() logoutAction;
  final UserProfile? user;

  const Profile(this.logoutAction, this.user, {final Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(user?.pictureUrl.toString() ?? ''),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Name: ${user?.name}'),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () async {
            await logoutAction();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget           
/// -----------------------------------
class Login extends StatelessWidget {
  final Future<void> Function() loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError, {final Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            await loginAction();
          },
          child: const Text('Login'),
        ),
        Text(loginError),
      ],
    );
  }
}

/// -----------------------------------
///                 App                
/// -----------------------------------

void main() => runApp(const LoginPage());

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// -----------------------------------
///              App State            
/// -----------------------------------

class _LoginPageState extends State<LoginPage> {
  bool isBusy = false;
  late String errorMessage;
  Credentials? _credentials;
  late Auth0 auth0;

   @override
     void initState() {
    super.initState();

    auth0 = Auth0('dev-s3wi816arvcpujfw.us.auth0.com', 'M7Rkt5TIMDyt4IovW1va9VGFy0eR14Oa');
    errorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          
          const Spacer(),
          const Text("Please login to view information about your emergency contacts."),
          Center(
            child: isBusy
                ? const CircularProgressIndicator()
                : _credentials != null
                    ? Profile(logoutAction, _credentials?.user)
                    : Login(loginAction, errorMessage),
          ), // 👈 Updated code
          const Spacer(),
        ])
      ),
    );
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final Credentials credentials = await auth0.webAuthentication(scheme: appScheme).login();

      setState(() {
        isBusy = false;
        _credentials = credentials;
      });
    } on Exception catch (e, s) {
      debugPrint('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        errorMessage = e.toString();
      });
    }
  }
  Future<void> logoutAction() async {
    await auth0.webAuthentication(scheme: appScheme).logout();

    setState(() {
      _credentials = null;
    });
  }
}