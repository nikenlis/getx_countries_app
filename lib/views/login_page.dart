import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_countries_app/app/theme/app_color.dart';
import 'package:getx_countries_app/controllers/auth_controller.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';
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

  late final AuthController controller;

  String? emailError;
  String? passwordError;

  void _submitLogin() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      controller.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    controller = Get.find<AuthController>();

    ever(controller.errorMessage, (message) {
      if (message != null) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          title: const Text("Login Failed"),
          description: Text(message),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(16),
        );

        controller.errorMessage.value = null;
      }
    });
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
      body: Stack(
        children: [
          /// ================= BACKGROUND GLOW =================
          Positioned(
            top: -120,
            left: -80,

            child: Container(
              width: 250,
              height: 250,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: primary.withValues(alpha: 0.4),
              ),
            ),
          ),

          Positioned(
            bottom: -120,
            right: -80,

            child: Container(
              width: 280,
              height: 280,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: accent.withValues(alpha: 0.35),
              ),
            ),
          ),

          /// ================= CONTENT =================
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView(
                  padding: const EdgeInsets.all(24),

                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),

                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            /// ================= LOGO =================
                            Container(
                              width: 90,
                              height: 90,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFA855F7),

                                    Color(0xFFEC4899),
                                  ],
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 30,

                                    color: primary.withValues(alpha: 0.4),
                                  ),
                                ],
                              ),

                              child: Icon(Icons.public, color: base, size: 42),
                            ),

                            const SizedBox(height: 28),

                            /// ================= TITLE =================
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                color: base,
                                fontSize: 32,
                                fontWeight: bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "Sign in to continue exploring\ncountries around the world",

                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: base.withValues(alpha: 0.7),
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 40),

                            /// ================= GLASS CARD =================
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),

                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20,

                                  sigmaY: 20,
                                ),

                                child: Container(
                                  padding: const EdgeInsets.all(24),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),

                                    color: base.withValues(alpha: 0.08),

                                    border: Border.all(
                                      color: base.withValues(alpha: 0.1),
                                    ),
                                  ),

                                  child: Form(
                                    key: _formKey,

                                    child: Column(
                                      children: [
                                        FormItems(
                                          controller: emailController,
                                          textInputAction: TextInputAction.next,
                                          errorText: emailError,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          title: "Email",
                                          hintTitle: "your@email.com",
                                          isShowHint: true,
                                          iconPrefix: LucideIcons.mail,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Email is required";
                                            }
                                            if (!EmailValidator.validate(
                                              value.trim(),
                                            )) {
                                              return "Please enter a valid email";
                                            }

                                            return null;
                                          },
                                        ),

                                        const SizedBox(height: 18),

                                        FormItems(
                                          controller: passwordController,
                                          textInputAction: TextInputAction.done,
                                          errorText: passwordError,
                                          textInputType:
                                              TextInputType.visiblePassword,
                                          title: "Password",
                                          hintTitle: "Enter your password",
                                          isShowHint: true,
                                          obsecureText: true,
                                          iconVisibility: true,
                                          iconPrefix: LucideIcons.lock,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Password cannot be empty";
                                            }
                                            if (value.trim().length < 8) {
                                              return "Password must be at least 8 characters";
                                            }

                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 24),

                                        /// ================= BUTTON =================
                                        controller.obx(
                                          (_) {
                                            return SizedBox(
                                              width: double.infinity,
                                              height: 56,
                                              child: ElevatedButton(
                                                onPressed: _submitLogin,
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18,
                                                        ),
                                                  ),
                                                ),

                                                child: Ink(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [primary, accent],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Sign In",
                                                      style: TextStyle(
                                                        color: base,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },

                                          onLoading: Container(
                                            width: double.infinity,
                                            height: 56,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  primary,
                                                  accent,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),

                                            child: const Center(
                                              child: SizedBox(
                                                width: 22,
                                                height: 22,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: base,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            /// ================= FOOTER =================
                            Text(
                              "Fake Login Demo • GetX MVC",
                              style: TextStyle(
                                color: base.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
