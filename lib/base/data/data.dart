library data;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../firebase_options.dart';
import '../../main.dart';
import '../views/components/components.dart';
import '../views/pages/pages.dart';
import 'provider/export.provider.dart';

// helper
part 'helper/theme.dart';
part 'helper/storage.service.dart';
part 'helper/strings.dart';
part 'helper/network.dart';
part 'helper/custom.error.dart';
part 'helper/constants.dart';
part 'helper/helper.dart';
part 'helper/chat.functions.dart';
part 'helper/notifications.controller.dart';

// routes
part 'routes/app.routes.dart';
part 'routes/route.generator.dart';
// models
part 'models/user.dart';
part 'models/trip.dart';
part 'models/package.dart';
part 'models/address.dart';
part 'models/shipment.dart';
part 'models/package.request.dart';
part 'models/notifications.dart';
part 'models/faq.feed.dart';
part 'models/order.dart';
part 'models/chat.dart';
