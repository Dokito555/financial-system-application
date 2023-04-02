import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_paths.dart';
import '../../../core/utility/state_enum.dart';
import '../../components/loading.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
  late String email;
  late String password;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordHide = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHide = !_isPasswordHide;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Form(
            key: _addPointKey,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      _header(context),
                      _signInForm(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _forgotPassword(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _loginButton(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Doesn\'t have an account?'),
                          TextButton(
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 15, color: AppColorConstants.primaryColor),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutePaths.signUpPageRoute
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    )
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Image.asset('images/IDNBS.png')),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20),
            )),
      ],
    );
  }

  Widget _signInForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Your Email',
            labelText: 'Email',
          ),
          autofocus: false,
          validator: (value) {
            if (value!.isEmpty) {
              return "Email must not be empty";
            }
            return null;
          },
          onChanged: (String value) {
            email = value;
          },
          onSaved: (String? value) {
            email = value!;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Input Your Password',
            labelText: 'Password',
            suffixIcon: GestureDetector(
              onTap: () {
                _togglePasswordVisibility();
              },
              child: Icon(
                  _isPasswordHide ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          autofocus: false,
          obscureText: _isPasswordHide,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return "Password must not be empty";
            }
            return null;
          },
          onChanged: (String value) {
            password = value;
          },
          onSaved: (String? value) {
            password = value!;
          },
        )
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    Future<void> forgotPassword() async {
      var authNotifier =
          Provider.of<FirebaseAuthNotifier>(context, listen: false);

      await authNotifier.authResetPassword(email: email);

      if (authNotifier.signUpStatus == Status.Error) {
        ShowToast.toast(authNotifier.message);
      } else if (authNotifier.signUpStatus == Status.Success) {
        ShowToast.toast(authNotifier.message);
      } else {
        ShowToast.toast(authNotifier.message);
      }
    }

    return TextButton(
      onPressed: () {
        forgotPassword();
      },
      child: const Text('Forgot Password?', style: TextStyle(color: AppColorConstants.primaryColor),),
    );
  }

  Widget _loginButton(BuildContext context) {

    var authNotifier = Provider.of<FirebaseAuthNotifier>(context);

    Future<void> signIn() async {

      await authNotifier.authSignInEmailPassword(email: email, password: password);

      if (authNotifier.signInStatus == Status.Error) {
        ShowToast.toast(authNotifier.message);
      } else if (authNotifier.signInStatus == Status.Success) {
        ShowToast.toast(authNotifier.message);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutePaths.homeRoute);
      } else {
        ShowToast.toast(authNotifier.message);
      }

    }

    return authNotifier.signInStatus == Status.Loading 
    ? const Center(child: CircularProgressIndicator())
    : Container(
        width: MediaQuery. of(context).size.width,
        height: 50,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColorConstants.primaryColor
          ),
          child: const Text('Login'),
          onPressed: () async {
            if (!_addPointKey.currentState!.validate()) {
              return;
            }
            signIn();
          },
        )
      );
  }

}
