import 'package:evently/app_them.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

AppLocalizations appLocalizations=    AppLocalizations.of(context)!;
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
                  controller: nameController,
                  hintText: appLocalizations.name,
                  prefixIcons: 'name',
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Invalid Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultTextFormFiled(
                  controller: emailController,
                  hintText: appLocalizations.email,
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
                  hintText: appLocalizations.password,
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
                DefaultElevatedButton(
                    Lable: appLocalizations.register,
                    onPressed: Login),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.haveaccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName),
                      child: Text(appLocalizations.login),
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
      FirebaseService.Registe(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text)
          .then((user) {
        Provider.of<UserProvider>(context, listen: false).updateuser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
        String? errorMessage;
        if (error is FirebaseAuthException) {
         errorMessage= error.message;
        }
        Fluttertoast.showToast(
            msg: errorMessage??'Eroor to Login',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppThem.red,
            textColor: Colors.black,
            fontSize: 16.0);
      });
    }
  }
}
