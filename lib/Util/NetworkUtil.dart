import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  static final String tokenKey = "";
  final JsonDecoder _decoder = new JsonDecoder();

  String concatParams(String url, Map params) {
    params.keys.forEach((k) {
      url = url + "/" + params[k].toString();
    });
    return url;
  }

  Future<dynamic> insert(String? url,
      [String? params, bool returnRaw = false]) async {
    var client = new http.Client();
    Map<String, String> header = {'Content-Type': 'application/json'};
    Encoding? encode = Encoding.getByName("utf-8");

    return http
        .post(
          Uri(
            host: url,
          ),
          headers: header,
          body: params,
          encoding: encode,
        )
        .whenComplete(() => client.close())
        .timeout(Duration(seconds: 45))
        .then((http.Response response) {
      if (returnRaw) {
        return response;
      }

      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      return _decoder.convert(res);
    }).catchError((error) => print(error.toString()));
  }

  Future<void> main(List<String> arguments) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
