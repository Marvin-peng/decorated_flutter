import 'package:dio/dio.dart';
import 'package:framework/framework.dart';
import 'package:meta/meta.dart';

class HttpUtils {
  static String baseUrl;

  static void init(String url) {
    assert(isNotEmpty(url));
    baseUrl = url;
  }

  ///
  /// Map转成http请求参数的形式
  ///
  static String map2Url(
    Object data, {
    @required String baseUrl,
    String path = '',
  }) {
    String result = '';

    if (data is FormData) {
      data.entries.forEach((entry) {
        result = '${entry.key}=${entry.value}&$result';
      });
      result = '$baseUrl$path?$result';
    } else if (data is Map) {
      data.forEach((key, value) {
        result = '$key=$value&$result';
      });
      result = '$baseUrl$path?$result';
    }
    return Uri.encodeFull(result);
  }
}
