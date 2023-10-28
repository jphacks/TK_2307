import 'package:http/http.dart' as http;

const DOMAIN = "us-central1-trainwindowguide.cloudfunctions.net";

Future<http.Response> execGetRequest(String path) async {
  return await http.get(Uri.https(DOMAIN, path));
}

Future<http.Response> execGetRequestWithParam(String path, Map<String, dynamic> param) async {
  return await http.get(Uri.https(DOMAIN, path, param));
}

Future<http.Response> execPostRequestWithParam(String path, Map<String, dynamic> param) async {
  return await http.post(Uri.https(DOMAIN, path), body: param);
}