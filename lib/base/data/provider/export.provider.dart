library providers;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data.dart';

part "providers.dart";

// cubits
part "cubit/auth.cubit.dart";
part "cubit/new.item.cubit.dart";
part "cubit/details.item.cubit.dart";

// blocs
part "bloc/auth.bloc.dart";
part "bloc/trip.bloc.dart";
part "bloc/package.bloc.dart";
part 'bloc/user.bloc.dart';
part 'bloc/order.bloc.dart';
part 'bloc/package.request.dart';

// events
part "events/auth.events.dart";
part "events/trip.events.dart";
part "events/package.events.dart";
part "events/user.events.dart";
part 'events/order.events.dart';
part 'events/package.request.events.dart';

// states
part "states/auth.states.dart";
part "states/trip.states.dart";
part "states/package.states.dart";
part "states/user.states.dart";
part 'states/order.states.dart';
part 'states/package.request.states.dart';

// repos
part "repos/auth.repo.dart";
part "repos/trips.repo.dart";
part "repos/package.repo.dart";
part "repos/user.repo.dart";
part 'repos/order.repo.dart';
part 'repos/package.request.repo.dart';
