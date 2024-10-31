import 'package:carpark_display/data/model/last_gate.dart';
import 'package:carpark_display/domain/model/last_gate_model.dart';
import 'package:carpark_display/domain/repository/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

class ApiService implements ApiRepository {
  ApiService(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'http://localhost:4000';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<LastGateModel> getLastGate() async {
    final extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    const Map<String, dynamic>? data = null;
    final options = _setStreamType<LastGate>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
        .compose(
          _dio.options,
          '/api/gate_logs/last',
          queryParameters: queryParameters,
          data: data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final result = await _dio.fetch<Map<String, dynamic>>(options);
    late LastGate value;
    try {
      value = LastGate.fromJson(result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, options);
      rethrow;
    }
    return value.toLastGateModel();
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
