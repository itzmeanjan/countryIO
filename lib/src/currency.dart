import 'dart:io' show HttpClient, HttpClientRequest, HttpClientResponse;
import 'dart:convert' show utf8, json;
import 'dart:async' show Completer;

class Currency {
  String targetURL;
  Currency({this.targetURL: 'http://country.io/currency.json'});

  /// Fetches an iso2 country code to country currency code mapping from country.io
  Future<Map<String, String>> fetch() {
    var completer = Completer<Map<String, String>>();
    HttpClient()
        .getUrl(Uri.parse(targetURL))
        .then(
          (HttpClientRequest req) => req.close(),
          onError: (e) => completer.complete({}),
        )
        .then(
          (HttpClientResponse resp) =>
              resp.transform(utf8.decoder).transform(json.decoder).listen(
                    (data) =>
                        completer.complete(Map<String, String>.from(data)),
                    onError: (e) => completer.complete({}),
                    cancelOnError: true,
                  ),
          onError: (e) => completer.complete({}),
        );
    return completer.future;
  }
}
