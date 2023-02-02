import 'package:bio_trap/helper/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:bio_trap/helper/dio_interceptors.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../util/app_constants.dart';

class DioUtilNew {
  static DioUtilNew? _instance;
  static Dio? _dio;

  static DioUtilNew? getInstance() {
    if (_instance == null) {
      _dio = Dio(_getOptions());
      _dio!.interceptors.add(CustomInterceptors());
      _dio!.interceptors.add(DioCacheInterceptor(options: CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.request,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      )));
    }
    return _instance;
  }


  static Dio? get dio => _dio;

  static void setDioAgain() {
    _dio = Dio(_getOptions());
  }

  static BaseOptions _getOptions() {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
    );

    options.connectTimeout = 20 * 1000; //10 sec
    options.receiveTimeout = 20 * 1000; //20 sec
    options.baseUrl = AppConstants.BASE_URL;
    options.headers = {
      'locale': "en",
      "appid": "VYi\$upl88HQPy5s02",
      'Authorization': "Bearer ${CacheHelper.getData(key: AppConstants.token)}"
      // 'Authorization': "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLWlzdGNocmF0Lm1hemFkYWsubmV0XC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY0NjkwNTE0NiwiZXhwIjoxNjUwNTA1MTQ2LCJuYmYiOjE2NDY5MDUxNDYsImp0aSI6InpHUm5mNzVPYUdIaG9rd2wiLCJzdWIiOjMsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.JNbMo91I1l9NeKQliAeec51yZqeNtCl6KeKkJ25WHqo"
    };
    options.queryParameters = {};

    return
      options;
  }

  //this just returns the language key
  static String handleDioError(DioError dioError) {
    String errorDescription = "";
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorDescription = "request_cancelled";
        break;
      case DioErrorType.connectTimeout:
      //Connection timeout with API server
        errorDescription = "timeout";
        break;
      case DioErrorType.other:
        errorDescription = "checkout_internet";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "timeout";
        break;
      case DioErrorType.response:
        print("Received invalid status code: ${dioError.response!.statusCode}");
        errorDescription = "unknown_error";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "timeout";
        break;
    }
    return errorDescription;
  }
}
