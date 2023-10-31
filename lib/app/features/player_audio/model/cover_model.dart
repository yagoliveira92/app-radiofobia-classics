import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class CoverModel {
  Future<String> getStreamingMetadata({required String url}) async {
    var response = await http.get(Uri.parse('$url/7.html')).catchError(
          (_) => Future.value(
            Future.value(
              http.Response('', 404),
            ),
          ),
        );
    if (response.statusCode == 200) {
      return convert.utf8.decode(response.bodyBytes);
    }
    return '';
  }
}
