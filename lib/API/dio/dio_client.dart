import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  static late Dio _dio;
  static late CookieJar cookieJar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage('${dir.path}/.cookies/'),
    );

    final baseOptions = BaseOptions(
      baseUrl: 'http://36.92.75.178:8001',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    _dio = Dio(baseOptions);
    _dio.interceptors.add(CookieManager(cookieJar));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ));
  }

  // This is the correct way to access it now
  static Dio get dio => _dio;
}
