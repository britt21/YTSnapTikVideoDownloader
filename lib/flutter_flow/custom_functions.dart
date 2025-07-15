import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

String buildurl(
  String? videourl,
  String? videofomat,
) {
  print('starrting::: ====' +
      'https://tubesaver-production.up.railway.app/testdownload?url=${videourl}&fomat=${videofomat}');

  return "https://tubesaver-production.up.railway.app/testdownload?url=${videourl}&fomat=${videofomat}";
}

String buildurlmp3(
  String? videourl,
  String? videofomat,
) {
  print('starrting::: ====' +
      'https://tubesaver-production.up.railway.app/testdownloadmp3?url=${videourl}&fomat=${videofomat}');

  return "https://tubesaver-production.up.railway.app/testdownloadmp3?url=${videourl}&fomat=${videofomat}";
}
