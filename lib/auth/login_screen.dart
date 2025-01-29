import 'package:evently/auth/register_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 24,
                ),
                DefaultTextFormFiled(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcons: 'email',
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultTextFormFiled(
                  controller: passwordController,
                  hintText: 'password',
                  prefixIcons: 'password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password can not be Less than 8 characters ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                DefaultElevatedButton(Lable: 'Login', onPressed: Login),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’`t Have Account ?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(RegisterScreen.routeName),
                      child: Text('Create Account'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Login() {
    if (formKey.currentState!.validate()) {
      FirebaseService.login(
              email: emailController.text, password: passwordController.text)
          .then((user) {
        Provider.of<UserProvider>(context, listen: false).updateuser(user);
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      }).catchError((_) {
        print(_);
      });
    }
  }
}
