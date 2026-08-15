import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

// Engine base URL — same origin as the served page unless overridden at build.
final String kEngineBaseUrl = _resolveEngineBaseUrl();
String _resolveEngineBaseUrl() {
  const fromEnv = String.fromEnvironment('ENGINE_BASE_URL', defaultValue: '');
  if (fromEnv.isNotEmpty) return fromEnv;
  final origin = Uri.base.origin;
  return origin.isNotEmpty && origin.startsWith('http')
      ? origin
      : 'http://localhost:3000';
}

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
