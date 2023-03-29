import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_financial/core/utility/validators.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_paths.dart';
import '../../../core/utility/state_enum.dart';
import '../../components/loading.dart';
import '../../components/show_toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                      _signUpForm(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _signUpButton(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Already have an account?'),
                          TextButton(
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutePaths.signInPageRoute);
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
    ));
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Finance App',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 20),
            )),
      ],
    );
  }

  Widget _signUpForm(BuildContext context) {
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
            if (Validators.isValidEmail(value) == false) {
              return "Invalid Email";
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
            // if (Validators.isValidPassword(value) == false) {
            //   return "Invalid Password";
            // }
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

  Widget _signUpButton(BuildContext context) {
    var authNotifier =
        Provider.of<FirebaseAuthNotifier>(context, listen: false);

    Future<void> signUp() async {
      onLoading;

      await authNotifier.authSignUpEmailPassword(
          email: email, password: password);

      if (authNotifier.status == Status.Error) {
        ShowToast.toast(authNotifier.message);
        // Navigator.pop(context);
      } else if (authNotifier.status == Status.Success) {
        ShowToast.toast(authNotifier.message);
        Navigator.pushReplacementNamed(context, AppRoutePaths.signInPageRoute);
      } else {
        ShowToast.toast(authNotifier.message);
        Navigator.pop(context);
      }
    }

    return Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          child: const Text('Sign Up'),
          onPressed: () async {
            if (!_addPointKey.currentState!.validate()) {
              return;
            }
            signUp();
          },
        ));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
