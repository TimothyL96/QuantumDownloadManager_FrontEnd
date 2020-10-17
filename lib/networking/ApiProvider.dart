import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = "http://127.0.0.1:3333/";

  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      final response = await http.get(_baseUrl + url);

      responseJson = _response(response);
    } on SocketException {
      throw SocketException("No internet connection");
    }

    return responseJson;
  } // get(String)

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);

        return responseJson;
      case HttpStatus.unauthorized:
        throw HttpException("Unauthorized");
      default:
        throw HttpException(response.body.toString());
    } // switch
  } // _response
} // Class
