import 'package:dio/dio.dart';
import 'package:net_plugin/data_helper.dart';
import 'package:simple_logger/simple_logger.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;
  factory HttpManager() => _instance;
  HttpManager._internal({String baseUrl}){
    if ( null == _dio) {
      _dio = new Dio(new BaseOptions(
        connectTimeout: 15000
      ));
    }
  }

  static HttpManager getInstance(String baseUrl) {
    return _instance._baseUrl(baseUrl);
  }

  HttpManager _baseUrl(String baseUrl){
    if(_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  postHttp<T>(String url,{
    signKey,
    parameters,
    Function(T t) onSuccess,
    Function(String error) onError,
    }) async {
    final logger = SimpleLogger();
    try{
      var params = DataHelper.encryptParams(parameters, signKey);
      Response response;
      response = await _dio.post(url,data: params);
      logger.info('--------响应数据：' + response.toString());
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess(response.data);
          }
        } else {
          throw Exception('statusCode:${response.statusCode}');
        }
      logger.info('响应数据：' + response.toString());
    }catch(e){
      logger.info('请求出错：' + e.toString());
      onError(e.toString());
     }
    }

}