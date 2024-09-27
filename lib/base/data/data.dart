library data;

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

// helper
part 'helper/theme.dart';
part 'helper/storage.service.dart';
part 'helper/strings.dart';
part 'helper/network.dart';
part 'helper/custom.error.dart';
part 'helper/constants.dart';

// routes
part 'routes/app.routes.dart';
part 'routes/route.generator.dart';
// models
part 'models/user.dart';
