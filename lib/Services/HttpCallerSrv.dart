// import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';

class HttpCallerSrv {
  static String apiSrv = "https://www.cfdzkj.com:811/";
  static String _url = apiSrv + "AppApi/";

//(String controller, Map<String, dynamic> param,[String tk = ""])
  static Future<String> get(String controller,
      [Map<String, dynamic> param, String tk]) {
    return _call("GET", controller, param, tk);
  }

  static Future<String> post(String controller,
      [Map<String, dynamic> param, String tk]) {
    return _call("POST", controller, param, tk);
  }

  static Future<String> _call(String ct, String controller,
      [Map<String, dynamic> param, String tk]) async {
    if (param != null) {
      print(
          "@@@ HttpCallerSrv._call => $ct / controller : $controller / param : $param");
      // print(param); / tk : $tk
    }
    // print("@@@ HttpCallerSrv._call tk => " + tk);

    Dio dio = Dio();
    // dio.options.responseType = ResponseType.json;
    // dio.options.contentType = ContentType.json;
    // if (tk != "") {
    //   dio.options.headers
    //       .addAll({HttpHeaders.authorizationHeader: "BasicAuth " + tk});
    //   // print("@@@ HttpCallerSrv.get tk => " + tk);
    // }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          options.responseType = ResponseType.json;
          options.contentType = ContentType.json.toString();
          if (tk != null && tk != "") {
            options.headers
                .addAll({HttpHeaders.authorizationHeader: "BasicAuth " + tk});
            // print("@@@ HttpCallerSrv._call tk => " + tk);
          }
          // print("\n================== 请求数据 ==========================");
          // print("url = ${options.uri.toString()}");
          // print("headers = ${options.headers}");
          // print("params = ${options.data}");
        },
      ),
    );
    // , onResponse: (Response response) {
    //   // return response.toString();
    //   // print("\n================== 响应数据 ==========================");
    //   // print("code = ${response.statusCode}");
    //   // print("data = ${response.data}");
    //   // print("\n");
    //   print("@@@ HttpCallerSrv._call() onResponse(response : ${response.statusCode})");
    //   // return response.toString();
    // }
    // , onError: (DioError e) {
    //   // print(
    //   //     "e.response = ${e.response.toString()}"); // {"Message":"已拒绝为此请求授权。"}
    //   // print("*** HttpCallerSrv.$ct e.response = ${e.response.toString()}");
    //   // if (e.response.statusCode == 401) {
    //   //   return "http401";
    //   // }

    //   // print("\n================== 错误响应数据 ======================");
    //   // print("\n");
    //   print("*** HttpCallerSrv._call() onError(e : ${e.response.statusCode})");
    //   // return "http" + e.response.statusCode.toString();
    // }),

    // print("@@@ HttpCallerSrv.get url => " + _url + controller);

    Response response;
    if (ct == "GET") {
      // print("@@@ HttpCallerSrv.get _url + controller => " + _url + controller);
      response = await dio.get(
        _url + controller,
        queryParameters: param,
        // new Options(responseType:ResponseType.JSON),response = await
      );
      // .then((f) {
      //   print("@@@ HttpCallerSrv.get f : $f");
      //   return f;
      // }).catchError((e) {
      //   // print("@@@ HttpCallerSrv.get response : $response");
      //   print("@@@ HttpCallerSrv.get e : $e");
      //   return errCodeGet;
      // });
    } else if (ct == "POST") {
      response = await dio.post(
        _url + controller,
        //以下两个参数最好一起传
        data: param, //如果对方的参数是 dynamic 则必须传此处
        // queryParameters: param,  //如果对方的参数是一对一的类型，则必须传此处
        // options: new Options(responseType:ResponseType.json),
        // new Options(responseType:ResponseType.JSON),response = await
      );
      // .then((f) {
      //   print("@@@ HttpCallerSrv.post f : $f");
      //   return f;
      // }).catchError((e) {
      //   print("@@@ HttpCallerSrv.post e : $e");
      //   return errCodePost;
      // });
      // print("@@@ HttpCallerSrv.post response : $response");
    }

    // print("@@@ HttpCallerSrv.$ct response : $response");
    // print("@@@ HttpCallerSrv.$ct response.statusCode : ${response.statusCode}");

    // // if (response.statusCode == 401) {
    // //   // Navigator.of(context).pushReplacementNamed("/myset");
    // //   return "http401";
    // // }
    // // print("@@@ HttpCallerSrv.$ct data => " + response.toString());
    return response.toString();
  }

  static getData(String controller,
      [Map<String, dynamic> param, String tk]) async {
    // print(
    //     "@@@ HttpCallerSrv.getData => GET / controller : ${_url + controller} / param : $param / tk : $tk"); //

    Dio dio = Dio();
    dio.options.responseType = ResponseType.json;
    dio.options.contentType = ContentType.json.toString();
    if (tk != "") {
      dio.options.headers
          .addAll({HttpHeaders.authorizationHeader: "BasicAuth " + tk});
    }

    String _path = _url + controller;
    //  print("@@@ HttpCallerSrv.getDate => _path : $_path");
    return await dio.get(
      _path,
      queryParameters: param,
    );
    // .then((f) {})
    // .catchError((e) {});
  }

  static String errCodeParam = '{"ret":1,"message":"参数错误"}';
  static String errCodeGet = '{"ret":2,"message":"获取数据错误"}';
  static String errCodePost = '{"ret":3,"message":"执行错误"}';
}

// Dio dio = new Dio();
// // 添加拦截器
// if (Config.DEBUG) {
//  dio.interceptors.add(InterceptorsWrapper(
//    onRequest: (RequestOptions options){
//     print("\n================== 请求数据 ==========================");
//     print("url = ${options.uri.toString()}");
//     print("headers = ${options.headers}");
//     print("params = ${options.data}");
//    },
//    onResponse: (Response response){
//     print("\n================== 响应数据 ==========================");
//     print("code = ${response.statusCode}");
//     print("data = ${response.data}");
//     print("\n");
//    },
//    onError: (DioError e){
//     print("\n================== 错误响应数据 ======================");
//     print("type = ${e.type}");
//     print("message = ${e.message}");
//     print("stackTrace = ${e.stackTrace}");
//     print("\n");
//    }
//  ));
// }

/*
const httpHeaders={
    'Accept': 'application/json, text/plain, 
    'Authorization': '666',
    'Content-Type': 'application/json;charset=UTF-8',
    'Origin': 'http://localhost:8080',
    'Referer': 'http://localhost:8080/',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36',
};
*/
