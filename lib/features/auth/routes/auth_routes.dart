import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/auth/views/email_verification.dart';
import 'package:flutter_app/features/auth/views/forgot_password.dart';
import 'package:flutter_app/features/auth/views/login_page.dart';
import 'package:flutter_app/features/auth/views/reauthenticate_update_email.dart';

Map<String, Widget Function(BuildContext, RouteSettings)> authRoutes = {
  "login": (context, settings) => const LoginPage(),
  "forgot": (context, settings) => const ForgotPassword(),
  "email": (context, settings) => EmailVerification(),
  "reauthenticate": (context, settings) => const ProfileUpdateEmail(),
};
