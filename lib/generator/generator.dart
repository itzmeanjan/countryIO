import 'dart:convert' show json;
import 'dart:io' show File, FileMode;
import 'dart:async' show Completer;
import 'package:country_io/src/continent.dart';
import 'package:country_io/src/names.dart';
import 'package:country_io/src/iso3.dart';
import 'package:country_io/src/capital.dart';
import 'package:country_io/src/phone.dart';
import 'package:country_io/src/currency.dart';
import 'country_data.dart';

/// Data fetcher, parser and generator
///
/// Fetches all country details using companion classes and store each of them in CountryData instance
/// Finally encodes them in json string and writes into target file path provided in construtor
///
/// Remember, target file path should be a json file, for which user has write permission
class Generator {
  String targetPath;
  Generator(this.targetPath);

  /// Fetches all country data, encodes to json and write in a target json file, which is why it's main generator
  Future<bool> generate() {
    var completer = Completer<bool>();
    var allCountryData = <CountryData>[];
    Continent().fetch().then(
      (Map<String, String> data) {
        data.forEach(
          (iso2, continent) => allCountryData.add(
                CountryData(iso2)
                  ..continent =
                      continent, // setting continent for a certain country, identified by iso2 code
              ), // and pushing it into a list of CountryData, which stores references to each of those instances, each one storing data for a certain country
        );
        Names().fetch().then(
          (Map<String, String> data) {
            num index = 0;
            data.forEach(
              (iso2, name) => allCountryData[index++].name = name,
            );
            ISO3().fetch().then(
              (Map<String, String> data) {
                num index = 0;
                data.forEach(
                  (iso2, iso3) => allCountryData[index++].iso3 = iso3,
                );
                Capital().fetch().then(
                  (Map<String, String> data) {
                    num index = 0;
                    data.forEach(
                      (iso2, capital) =>
                          allCountryData[index++].capital = capital,
                    );
                    Phone().fetch().then(
                      (Map<String, String> data) {
                        num index = 0;
                        data.forEach(
                          (iso2, phone) =>
                              allCountryData[index++].phone = phone,
                        );
                        Currency().fetch().then(
                          (Map<String, String> data) {
                            num index = 0;
                            data.forEach(
                              (iso2, currency) =>
                                  allCountryData[index++].currency = currency,
                            );
                            try {
                              File.fromUri(Uri.parse(targetPath)).openWrite(
                                  mode: FileMode.write)
                                ..writeln(
                                  json.encode(
                                    Map<String,
                                        Map<String, String>>.fromEntries(
                                      allCountryData.map(
                                        (data) => MapEntry(
                                              data.iso2,
                                              data.getCountryDetails(),
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                                ..close().then(
                                    (val) => completer.complete(true),
                                    onError: (e) => completer.complete(false));
                            } on Exception {
                              completer.complete(false);
                            }
                          },
                          onError: (e) => completer.complete(false),
                        );
                      },
                      onError: (e) => completer.complete(false),
                    );
                  },
                  onError: (e) => completer.complete(false),
                );
              },
              onError: (e) => completer.complete(false),
            );
          },
          onError: (e) => completer.complete(false),
        );
      },
      onError: (e) => completer.complete(false),
    );
    return completer.future;
  }
}
