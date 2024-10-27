import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_error.freezed.dart';

@freezed
sealed class HttpRequestError with _$HttpRequestError {
  const factory HttpRequestError.network() = _Network;
  const factory HttpRequestError.notFound() = _NotFound;
  const factory HttpRequestError.server() = _Server;
  const factory HttpRequestError.unauthorized() = _Unauthorized;
  const factory HttpRequestError.badRequest() = _BadRequest;
  const factory HttpRequestError.local() = _Local;

  static HttpRequestError fromCode(int? code) {
    if (code == null) return const HttpRequestError.badRequest();

    if (code >= 500) return const HttpRequestError.server();

    if (code == 404) return const HttpRequestError.notFound();

    if (code == 401) return const HttpRequestError.unauthorized();

    if (code == 403) return const HttpRequestError.unauthorized();

    return const HttpRequestError.local();
  }

  static HttpRequestError fromException(Object e) {
    if (e is HttpRequestError) return e;
    // if (e is DioException) {
    //   if (e.type == DioExceptionType.badResponse) {
    //     return HttpRequestError.fromCode(e.response?.statusCode);
    //   }
    //   return const HttpRequestError.network();
    // }

    return const HttpRequestError.local();
  }
}
