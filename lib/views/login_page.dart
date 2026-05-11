import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/theme/app_color.dart';
import '../components/form.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool rememberMe = false;

  _submitLogin() {
    
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      body: LayoutBuilder(
            builder: (context, constraints) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logos/dramaprem-icon.png",
                          width: 64,
                          height: 64,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: base,
                            fontSize: 28,
                            fontWeight: extraBold,
                          ),
                        ),
                        Text(
                          "Sign in to continue watching",
                          style: TextStyle(
                            color: base,
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),

                        SizedBox(height: 14),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              FormItems(
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                errorText: emailError,
                                textInputType: TextInputType.emailAddress,
                                title: "Email",
                                hintTitle: "your@email.com",
                                isShowHint: true,
                                iconPrefix: LucideIcons.mail,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!EmailValidator.validate(value.trim())) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onChanged: (_) {
                                  if (emailError != null) {
                                    setState(() {
                                      emailError = null;
                                    });
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    if (value.trim().isEmpty) {
                                      emailError = 'Email is required';
                                    } else if (!EmailValidator.validate(
                                      value.trim(),
                                    )) {
                                      emailError =
                                          'Please enter a valid email address';
                                    } else {
                                      emailError = null;
                                    }
                                  });
                                },
                              ),

                              SizedBox(height: 14),
                              FormItems(
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                errorText: passwordError,
                                textInputType: TextInputType.visiblePassword,
                                title: "Password",
                                hintTitle: "Enter your password",
                                isShowHint: true,
                                obsecureText: true,
                                iconVisibility: true,
                                iconPrefix: LucideIcons.lock,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  if (value.trim().length < 8) {
                                    return "Password must be at least 8 characters";
                                  }
                                  return null;
                                },
                                onChanged: (_) {
                                  if (passwordError != null) {
                                    setState(() {
                                      passwordError = null;
                                    });
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    if (value.trim().isEmpty) {
                                      passwordError =
                                          "Password cannot be empty";
                                    } else if (value.trim().length < 8) {
                                      passwordError =
                                          "Password must be at least 8 characters";
                                    } else {
                                      passwordError = null;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        

                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              // onTap: !isLoading ? () {
                              //   _submitLogin();
                              // } : null,
                              child: Center(
                                child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                          color: base,
                                          fontSize: 16,
                                          fontWeight: medium,
                                        ),
                                      )
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: textSecondary,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                "or continue with",
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: textSecondary,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),   
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
    );
  }
}
