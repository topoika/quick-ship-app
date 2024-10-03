library providers;

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

// events
part "events/auth.events.dart";
part "events/trip.events.dart";

// states
part "states/auth.states.dart";
part "states/trip.states.dart";

// repos
part "repos/auth.repo.dart";
part "repos/trips.repo.dart";
