import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start YTSave API Group Code

// Single source of truth for the engine base URL.
// Local testing: http://localhost:3000  |  Production: your Railway/Firebase URL.
const String kEngineBaseUrl = String.fromEnvironment(
  'ENGINE_BASE_URL',
  defaultValue: 'http://localhost:3000',
);

class YTSaveAPIGroup {
  static String getBaseUrl() => kEngineBaseUrl;
  static Map<String, String> headers = {};
  static DownloadCall downloadCall = DownloadCall();
  static FormatcheckVTreeCall formatcheckVTreeCall = FormatcheckVTreeCall();
  static FormatChecker2Call formatChecker2Call = FormatChecker2Call();
}

class DownloadCall {
  Future<ApiCallResponse> call({
    String? url = '',
    String? fomat = '',
  }) async {
    final baseUrl = YTSaveAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'download',
      apiUrl: '${baseUrl}/save-video',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
        'fomat': fomat,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FormatcheckVTreeCall {
  Future<ApiCallResponse> call({
    String? url = '',
  }) async {
    final baseUrl = YTSaveAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'formatcheckVTree',
      apiUrl: '${baseUrl}/check-video3-stableV2AudioVideo',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.title''',
      ));
  String? thumbnail(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.thumbnail''',
      ));
  List? videolist(dynamic response) => getJsonField(
        response,
        r'''$.videoFormats''',
        true,
      ) as List?;
  List? audiofomats(dynamic response) => getJsonField(
        response,
        r'''$.audioFormats''',
        true,
      ) as List?;
}

class FormatChecker2Call {
  Future<ApiCallResponse> call({
    String? url = '',
  }) async {
    final baseUrl = YTSaveAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'formatChecker2',
      apiUrl: '${baseUrl}/check-video2-stable',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? thumbnailurl(dynamic response) => (getJsonField(
        response,
        r'''$[:].thumbnail''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? filesize(dynamic response) => (getJsonField(
        response,
        r'''$[:].fileSize''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? resolution(dynamic response) => (getJsonField(
        response,
        r'''$[:].resolution''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? mp4ormp3format(dynamic response) => (getJsonField(
        response,
        r'''$[:].extension''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? format(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

/// End YTSave API Group Code

/// Start YTSaveVTwo Group Code

class YTSaveVTwoGroup {
  static String getBaseUrl() => kEngineBaseUrl;
  static Map<String, String> headers = {};
  static GetTasksCall getTasksCall = GetTasksCall();
  static DownloadVTwooCall downloadVTwooCall = DownloadVTwooCall();
  static FormatCheckerVTreeCall formatCheckerVTreeCall =
      FormatCheckerVTreeCall();
  static CheckVideoFormatsCall checkVideoFormatsCall = CheckVideoFormatsCall();
  static FormatChecker3AudioVideCall formatChecker3AudioVideCall =
      FormatChecker3AudioVideCall();
  static FormatCheckerVTwoCall formatCheckerVTwoCall = FormatCheckerVTwoCall();
}

class GetTasksCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = YTSaveVTwoGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getTasks',
      apiUrl: '${baseUrl}/tasks',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DownloadVTwooCall {
  Future<ApiCallResponse> call({
    String? url = '',
    String? fomat = '',
  }) async {
    final baseUrl = YTSaveVTwoGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'downloadVTwoo',
      apiUrl: '${baseUrl}/testdownload',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
        'fomat': fomat,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FormatCheckerVTreeCall {
  Future<ApiCallResponse> call({
    String? url = '',
  }) async {
    final baseUrl = YTSaveVTwoGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'formatCheckerVTree',
      apiUrl: '${baseUrl}/check-video',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CheckVideoFormatsCall {
  Future<ApiCallResponse> call({
    String? url = '',
  }) async {
    final baseUrl = YTSaveVTwoGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'checkVideoFormats',
      apiUrl: '${baseUrl}/check-video3',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FormatChecker3AudioVideCall {
  Future<ApiCallResponse> call({
    String? url = '',
  }) async {
    final baseUrl = YTSaveVTwoGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'formatChecker3AudioVide',
      apiUrl: '${baseUrl}/check-video3-stableV2AudioVideo',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FormatCheckerVTwoCall {
  Future<ApiCallResponse> call({
    String? url = '',
  }) async {
    final baseUrl = YTSaveVTwoGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'formatCheckerVTwo',
      apiUrl: '${baseUrl}/check-video2-stable',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'url': url,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End YTSaveVTwo Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
