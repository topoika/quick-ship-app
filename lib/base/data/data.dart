library data;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../views/components/components.dart';
import '../views/pages/pages.dart';

// helper
part 'helper/theme.dart';
part 'helper/storage.service.dart';
part 'helper/strings.dart';
part 'helper/network.dart';
part 'helper/custom.error.dart';
part 'helper/constants.dart';
part 'helper/helper.dart';

// routes
part 'routes/app.routes.dart';
part 'routes/route.generator.dart';
// models
part 'models/user.dart';
part 'models/trip.dart';
part 'models/package.dart';
part 'models/address.dart';
