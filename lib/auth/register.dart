import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/provider/register_provider.dart';
import 'package:newstore/services/register_service.dart';
import 'package:newstore/widgets/auth_button.dart';
import 'package:newstore/widgets/auth_header.dart';
import 'package:newstore/widgets/auth_textFields.dart';
import 'package:newstore/widgets/snackbar.dart';
import 'package:newstore/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _RegisterScreenContent();
  }
}

class _RegisterScreenContent extends StatelessWidget {
  _RegisterScreenContent({super.key});

  RegisterService registerService = RegisterService();
  @override
  Widget build(BuildContext context) {
    print('registwe');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          // print("object");
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/login');
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    AuthHeader(
                      mainHeading: "Register",
                      subHeading: "Create your Account",
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width(context) * 0.08,
                      ),
                      child: Consumer<RegisterProvider>(
                          builder: (context, value, child) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height(context) * 0.05,
                            ),
                            AuthTextField(
                              errorText: value.nameError.isNotEmpty
                                  ? value.nameError
                                  : null,
                              obscureText: false,
                              label: "Name",
                              icon: FontAwesomeIcons.user,
                              controller: registerService.name,
                            ),
                            SizedBox(
                              height: height(context) * 0.03,
                            ),
                            AuthTextField(
                              errorText: value.emailError.isNotEmpty
                                  ? value.emailError
                                  : null,
                              obscureText: false,
                              label: "Email",
                              icon: FontAwesomeIcons.envelope,
                              controller: registerService.email,
                            ),
                            SizedBox(
                              height: height(context) * 0.03,
                            ),
                            AuthTextField(
                              errorText: value.passwordError.isNotEmpty
                                  ? value.passwordError
                                  : null,
                              errorMaxLines: 10,
                              label: "Password",
                              icon: Icons.password,
                              controller: registerService.password,
                              obscureText: true,
                              KeyboardType: TextInputType.visiblePassword,
                              // obscureText:
                              //     !context.watch<RegisterProvider>().passShow,
                              // suffixIcon: !context
                              //         .watch<RegisterProvider>()
                              //         .passShow
                              //     ? GestureDetector(
                              //         onTap: () {
                              //           context
                              //               .read<RegisterProvider>()
                              //               .passwordShow(true);
                              //         },
                              //         child: Icon(
                              //           FontAwesomeIcons.eyeSlash,
                              //           color: Colors.green,
                              //           size: width(context) *
                              //               0.04,
                              //         ))
                              //     : GestureDetector(
                              //         onTap: () {
                              //           context
                              //               .read<RegisterProvider>()
                              //               .passwordShow(false);
                              //         },
                              //         child: Icon(
                              //           FontAwesomeIcons.eye,
                              //           color: Colors.green,
                              //           size: width(context) *
                              //               0.04,
                              //         ),
                              //       ),
                            ),
                            SizedBox(
                              height: height(context) * 0.03,
                            ),
                            AuthTextField(
                              // obscureText: !context
                              //     .watch<RegisterProvider>()
                              //     .passShowConfirm,
                              label: "Confirm Password",
                              icon: Icons.password,
                              controller: registerService.confirmPassword,
                              obscureText: true,
                              KeyboardType: TextInputType.visiblePassword,
                              // suffixIcon: !context
                              //         .watch<RegisterProvider>()
                              //         .passShowConfirm
                              //     ? GestureDetector(
                              //         onTap: () {
                              //           context
                              //               .read<RegisterProvider>()
                              //               .passwordShowConfrim(true);
                              //         },
                              //         child: Icon(
                              //           FontAwesomeIcons.eyeSlash,
                              //           color: Colors.green,
                              //           size: width(context) *
                              //               0.04,
                              //         ))
                              //     : GestureDetector(
                              //         onTap: () {
                              //           context
                              //               .read<RegisterProvider>()
                              //               .passwordShowConfrim(false);
                              //         },
                              //         child: Icon(
                              //           FontAwesomeIcons.eye,
                              //           color: Colors.green,
                              //           size: width(context) *
                              //               0.04,
                              //         ),
                              //       ),
                            ),
                            SizedBox(
                              height: height(context) * 0.03,
                            ),
                            value.isLoading == true
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.green.shade100,
                                    color: Colors.green,
                                  )
                                : AuthButton(
                                    buttonText: "Register",
                                    onPressed: () async {
                                      int? code = await context
                                          .read<RegisterProvider>()
                                          .register(
                                            context,
                                            registerService.name.text,
                                            registerService.email.text,
                                            registerService.password.text,
                                            registerService
                                                .confirmPassword.text,
                                          );
                                      if (value.networkError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          content: SnackBarError(
                                            text: "Network Error",
                                          ),
                                        ));
                                      }
                                      if (code == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          content: SnackBarError(
                                            text: "Register Successfully",
                                          ),
                                        ));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextWidget(text: "Already Registered?"),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () { 
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: CustomTextWidget(
                            text: "Login",
                            color: Colors.green.shade300,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
