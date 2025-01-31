import 'package:flutter/material.dart';
import 'package:flutter_app/features/profile/views/profile_update_displayName.dart';
import 'package:flutter_app/features/profile/views/profile_update_phoneNumber.dart';

Map<String, Widget Function(BuildContext context, RouteSettings)>
    profileRoutes = {
  "profileDisplayName": (context, p1) => const ProfileUpdateDisplayName(),
  "phoneAuthPage": (context, p1) => PhoneAuthPage(),
};
