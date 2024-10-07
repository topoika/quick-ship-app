library components;

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/data.dart';
import '../../data/provider/export.provider.dart';

// common
part "common/custom.toast.dart";
part "common/text.variations.dart";
part "common/image.provider.dart";
part "common/buttons.dart";
part "common/custom.dialog.dart";
part "common/no.data.error.widget.dart";
part "common/loading.widgets.dart";

// inputs
part 'inputs/text.input.field.dart';
part 'inputs/validators.dart';
part 'inputs/phone.input.dart';
part 'inputs/drop.down.input.dart';
part 'inputs/image.pick.upload.dart';

// home page widget
part 'home/tasks.widget.dart';
part "home/stats.widget.dart";
part 'home/invite.join.community.widget.dart';

// trip page widget
part 'trip/create.trip.widgets.dart';
part 'trip/trip.items.dart';
part 'trip/notification.item.dart';

// package
part 'package/package.input.widgets.dart';
part 'package/package.list.item.dart';
part 'package/package.images.dart';

// order
part 'order/order.items.dart';
