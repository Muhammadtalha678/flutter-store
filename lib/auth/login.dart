import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newstore/auth/d.dart';
import 'package:newstore/auth/register.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/provider/login_provider.dart';
import 'package:newstore/secure_storage/secure_storage.dart';
import 'package:newstore/services/login_service.dart';
import 'package:newstore/widgets/auth_button.dart';
import 'package:newstore/widgets/auth_header.dart';
import 'package:newstore/widgets/auth_textFields.dart';
import 'package:newstore/widgets/snackbar.dart';
import 'package:newstore/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print("Login");
    return _LoginScreenContent();
  }
}

class _LoginScreenContent extends StatelessWidget {
  _LoginScreenContent({super.key});

  @override
  final LoginService loginService = LoginService();
  Widget build(BuildContext context) {
    print("login");
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        await SecureStorage().deleteData(
          "id",
        );
        await SecureStorage().deleteData(
          "productPrice",
        );
        await SecureStorage().deleteData(
          "productdiscountPrice",
        );
        Navigator.of(context).pop();
        // return true;
      },
      child: GestureDetector(
        onTap: () {
          // print("object");
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            // print("object");
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: myDefaultColor,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  AuthHeader(
                    onTap: () async {
                      await SecureStorage().deleteData(
                        "id",
                      );
                      await SecureStorage().deleteData(
                        "productPrice",
                      );
                      await SecureStorage().deleteData(
                        "productdiscountPrice",
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(context);
                    },
                    mainHeading: "Sign In To Your\nAccount",
                    subHeading: "Log In To Your Account",
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.08),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Consumer<LoginProvider>(
                            builder: (context, value, child) {
                          return AuthTextField(
                            textInputAction: TextInputAction.done,
                            // onEditingComplete: () => FocusNode().unfocus(),
                            KeyboardType: TextInputType.emailAddress,
                            label: "Email",
                            icon: FontAwesomeIcons.envelope,
                            obscureText: false,
                            controller: loginService.Email,
                            errorText: value.emailError.isNotEmpty
                                ? value.emailError
                                : null,
                            errorMaxLines: 2,
                          );
                        }),
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Consumer<LoginProvider>(
                            builder: (context, value, child) {
                          return AuthTextField(
                            KeyboardType: TextInputType.visiblePassword,
                            label: "Password",
                            icon: Icons.password,
                            obscureText: true,
                            controller: loginService.Password,
                            errorText: value.passwordError.isNotEmpty
                                ? value.passwordError
                                : null,
                          );
                        }),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextWidget(
                            text: "Forgot Password?",
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        Consumer<LoginProvider>(
                          builder: (context, value, child) {
                            if (!value.isLoading) {
                              return AuthButton(
                                buttonText: "Login",
                                onPressed: () async {
                                  await context
                                      .read<LoginProvider>()
                                      .loginMobileUser(
                                          context,
                                          loginService.Email.text,
                                          loginService.Password.text);
                                  if (await value.networkError) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            duration: Duration(seconds: 1),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: SnackBarError(
                                              text: "Internet Connection Error",
                                            )));
                                  }
                                  if (value.isLogin) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            duration: Duration(seconds: 1),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: SnackBarError(
                                              text: "User Login",
                                            )));
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            } else {
                              return CircularProgressIndicator(
                                backgroundColor: Colors.green.shade100,
                                color: Colors.green,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomTextWidget(
                            text: "Or login with",
                            // fontSize: 12,
                            fontSize: width(context) * 0.033,
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextWidget(
                              text: "Don't have an account?",
                              // fontSize: 14,
                              fontSize: width(context) * 0.04,
                            ),
                            SizedBox(
                              width: width(context) * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/register');
                                // Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => YourWidget(),
                                //   ),
                                //   (route) {
                                //     return false;
                                //   },
                                // );
                              },
                              child: CustomTextWidget(
                                text: "Register",
                                fontSize: width(context) * 0.04,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
