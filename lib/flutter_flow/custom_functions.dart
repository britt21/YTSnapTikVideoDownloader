import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

// Single source of truth for the engine base URL.
// Local testing: http://localhost:3000  |  Production: your Railway/Firebase URL.
const String kEngineBaseUrl = String.fromEnvironment(
  'ENGINE_BASE_URL',
  defaultValue: 'http://localhost:3000',
);

String buildurl(
  String? videourl,
  String? videofomat,
) {
  return "$kEngineBaseUrl/testdownload?url=${videourl}&fomat=${videofomat}";
}

String buildurlmp3(
  String? videourl,
  String? videofomat,
) {
  return "$kEngineBaseUrl/testdownloadmp3?url=${videourl}&fomat=${videofomat}";
}
