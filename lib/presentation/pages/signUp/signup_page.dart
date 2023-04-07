import 'package:flutter/material.dart';
import 'package:flutter_financial/core/routes/route_paths.dart';
import 'package:flutter_financial/core/utility/constants.dart';
import 'package:flutter_financial/core/utility/state_enum.dart';
import 'package:flutter_financial/core/utility/validators.dart';
import 'package:flutter_financial/data/model/user_model.dart';
import 'package:flutter_financial/presentation/components/show_toast.dart';
import 'package:flutter_financial/presentation/provider/firebase_auth_notifier.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String phoneNumber;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

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
                              style: TextStyle(fontSize: 15, color: AppColorConstants.primaryColor),
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
            )
          ),
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
          keyboardType: TextInputType.emailAddress,
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
            return null;
          },
          onChanged: (String value) {
            password = value;
          },
          onSaved: (String? value) {
            password = value!;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: phoneNumberController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Your Phone Number',
            labelText: 'Phone Number',
          ),
          autofocus: false,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) {
              return "Phone Number must not be empty";
            }
            return null;
          },
          onChanged: (String value) {
            phoneNumber = value;
          },
          onSaved: (String? value) {
            phoneNumber = value!;
          },
        )
      ],
    );
  }

  Widget _signUpButton(BuildContext context) {

    var authNotifier = Provider.of<FirebaseAuthNotifier>(context);

    Future<void> signUp() async {

      await authNotifier.authSignUpEmailPassword(email: email, password: password);
      await authNotifier.storeUser(user: UserModel(id: authNotifier.userUID, name: email, email: email, phoneNumber: phoneNumber));
      
      if (authNotifier.signUpStatus == Status.Error || authNotifier.storeUserStatus == Status.Error) {
        ShowToast.toast(authNotifier.message);
      } else if (authNotifier.signUpStatus == Status.Success && authNotifier.storeUserStatus == Status.Success) {
        ShowToast.toast(authNotifier.message);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutePaths.signInPageRoute);
      } else {
        ShowToast.toast(authNotifier.message);
        if (!context.mounted) return;
        Navigator.pop(context);
      }
    }

    return authNotifier.signUpStatus == Status.Loading
    ? const Center(child: CircularProgressIndicator())
    : Container(
        width: MediaQuery. of(context).size.width,
        height: 50,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorConstants.primaryColor
          ),
          child: const Text('Sign Up'),
          onPressed: () async {
            if (!_addPointKey.currentState!.validate()) {
              return;
            }
            signUp();
          },
        )
      );
  }
}
