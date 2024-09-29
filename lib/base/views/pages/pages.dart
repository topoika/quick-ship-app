library pages;

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quick_ship_app/base/data/provider/export.provider.dart';

import '../../data/data.dart';
import '../components/components.dart';

// views
part 'onboarding.dart';

// auth
part 'auth/login.dart';
part 'auth/register.dart';
part 'auth/forgot.password.dart';
part 'auth/reset.password.dart';
part 'auth/otp.verification.dart';

// tabs
part 'tabs/tabs.dart';
part "tabs/settings.dart";
part 'tabs/home.dart';

// user
part 'user/edit.profile.dart';
