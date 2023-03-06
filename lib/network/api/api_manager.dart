import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../core/error/api_exception.dart';
import '../../src/models/error_model/error_model.dart';

const String jsonContentType = 'application/json';

String token = "";

class ApiManager {
  Future _getToken() async {
    //token = 'Bearer ${GetStorage().read(AppPreferences.accessToken)}';

    token =
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjI2Zjc5NTNkOWU4Mjk1YTJiMmE3MjIyNTM2ZTlmYjgxM2YwNGJmNGEzNWUwNDNmNDMwMjBhOWFmNjU1MWQzNjU3Y2YwNzliZTcyMGQwNWUiLCJpYXQiOjE2NzA5MTY2NzkuNTg4NDE4MDA2ODk2OTcyNjU2MjUsIm5iZiI6MTY3MDkxNjY3OS41ODg0MjM5NjczNjE0NTAxOTUzMTI1LCJleHAiOjE3MDI0NTI2NzkuNTI1NTYyMDQ3OTU4Mzc0MDIzNDM3NSwic3ViIjoiMTEwIiwic2NvcGVzIjpbXX0.rs5Tk61lQN_YEt3E2XxlbdKQqpuG3RAN7LcFH5WCgaEJKXOOGZ70NP7y01mDZNsrFbksz708xMeBKZXK9rkPnuOJPztc85y3mrEbWM4yBw25JzGeuOeFK-0rT2NCFXaS1XHkT8iYfnpNS6eDQjfPuRLgeTntnSwzGnVj0U0r1abHKHPhSxd1j9sQ_H3yvmj3leLsEtiOV1AK_wv1JN7mQFABrZZqmf8X2HjQz7ZwUs8V0jDhFhlsOE5W7NLmiliX-crm1NPM47dt2pik1i8HWs1i70Vf34wP0fEsaD0A2RBpF8qfgMjLxODMW0AOQ1QkZB5N3evaSJKBK2MzWGDnOLZgqwQlr0DQEeUik0eqASLcLG3XQjtqwg2IApCuQiQjLYl12iPoNfYeaFpucsof2AYoeZwG_iUDGaxm960xDTxTil6pht4gi1wGzensQ9xYGfiqTo8oCD2Lh_IijbYf5XlTum7wmUA65CQhWYc7LG9QEhDas2s0QIuPnTKSnLATlNF87lJyal_K-39VS6fbadvoqCEq9PEjMzinwMgF7yQJijl05E6HsUuwOO21jGnOqg5Xlfzdk-mRga1hi7QJo_TgO22jWL9jRJVIjaLxrCQPgJm3n3u7CiWZ9OWh3Eb1d6RGIWsQ7FAj8yECujiiP2jg_5bP3vEIHf2JsP7tIS8';
  }

  var httpClient = http.Client();

  /// This method is used for call API for the `GET` method, need to pass API Url endpoint
  Future<dynamic> get(
    String? url, {
    String contentType = jsonContentType,
    bool isTokenMandatory = true,
  }) async {
    await _getToken();

    try {
      Map<String, String> headers = {
        'Content-Type': contentType,
      };

      if (isTokenMandatory) {
        headers['Authorization'] = token;
      }

      // Make get method api call with header
      final response = await http.get(
        Uri.parse(url ?? ""),
        headers: headers,
      );

      log('Response body of Get ${response.request!.url} -> ${response.body}');

      // Handle response and errors
      var responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // This method is used for call API for the `POST` method, need to pass API Url endpoint
  Future<dynamic> post(
    String? url,
    var parameters, {
    String contentType = jsonContentType,
    bool isTokenMandatory = true,
    Map<String, String>? headersParams,
  }) async {
    await _getToken();

    try {
      // Declare the header for the request, if user not loged in then pass empty array as header
      Map<String, String> headers = {
        'Content-Type': contentType,
      };
      if (headersParams != null) {
        headers.addAll(headersParams);
      }

      if (isTokenMandatory) {
        headers['Authorization'] = token;
      }

      // Make the post method api call with header and given parameter
      final response = await http.post(
        Uri.parse(url ?? ""),
        headers: headers,
        body: parameters,
      );

      var responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);

        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);

        return responseJson;
      case 400:
        ErrorModel errorModel = ErrorModel.fromJson(json.decode(response.body));

        throw BadRequestException(
          'Err:${response.statusCode} ${errorModel.message}',
          errorModel.toJson(),
        );
      case 401:
        if (response.body.runtimeType is JsonCodec) {
          ErrorModel errorModel =
              ErrorModel.fromJson(json.decode(response.body));
          throw UnauthorisedException(
            'Err:${response.statusCode} ${errorModel.message}',
            errorModel.toJson(),
          );
        }

        return;

      case 403:
      case 404:
        ErrorModel errorModel = ErrorModel.fromJson(json.decode(response.body));
        log("ErrorModel ${response.statusCode} -> ${errorModel.message}");

        throw UnauthorisedException(
          'Err:${response.statusCode} ${errorModel.message}',
          errorModel.toJson(),
        );
      case 500:
        ErrorModel errorModel = ErrorModel.fromJson(json.decode(response.body));
        var decodedJson = json.decode(response.body);
        String error = decodedJson["message"];
        throw FetchDataException(
          'Err:${response.statusCode} $error',
          errorModel.toJson(),
        );
      default:
        ErrorModel errorModel = ErrorModel.fromJson(json.decode(response.body));
        throw FetchDataException(
          'Err:${response.statusCode} ${errorModel.message}',
          errorModel.toJson(),
        );
    }
  }
}
