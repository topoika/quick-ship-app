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
part "splash.dart";
part 'faqs.dart';
part 'no.internet.page.dart';

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
part 'tabs/trips.dart';
part 'tabs/chat.dart';
part 'tabs/shipments.dart';

// user
part 'user/edit.profile.dart';
part "activities/package/my.packages.dart";
part "user/my.orders.page.dart";

// activities
part 'activities/package/create.package.dart';
part 'activities/trip/create.trip.dart';
part 'activities/trip/trip.details.dart';
part 'activities/trip/available.route.trips.dart';
part 'activities/package/package.details.dart';
part "activities/package/package.requests.dart";

// shipments
part 'activities/shipment/rate.shipment.dart';
