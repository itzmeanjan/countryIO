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
/// Finally encodes them in json string and writes into target file path, if provided in construtor as named optional parameter
///
/// Remember, target file path should be a json file, for which user has write permission, if it's provided
class Generator {
  String targetPath;
  Generator({this.targetPath});

  /// Fetches all country data, encodes to json and write in a target json file, does all heavy lifting
  ///
  /// Will return a Map<String, Map<String, String>> holding entry for each country, if successful else {}
  ///
  /// Every key of this map will be an iso2 country code, helping to identify a certain country
  /// And value entry for that iso2 country code will be another Map<String, String>
  ///
  /// Example construct:
  /// {
  ///   .
  ///   .
  ///   .
  ///   iso2:
  ///   {
  ///      'continent': continent ?? '',
  ///      'name': name ?? '',
  ///      'iso3': iso3 ?? '',
  ///      'capital': capital ?? '',
  ///      'phone': phone ?? '',
  ///      'currency': currency ?? '',
  ///    }
  ///   .
  ///   .
  ///   .
  /// }
  Future<Map<String, Map<String, String>>> generate() {
    var completer = Completer<Map<String, Map<String, String>>>();
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
                            var tmp =
                                Map<String, Map<String, String>>.fromEntries(
                              allCountryData.map(
                                (data) => MapEntry(
                                      data.iso2,
                                      data.getCountryDetails(),
                                    ),
                              ),
                            ); // store processed data in temporary variable
                            if (targetPath != null)
                              try {
                                File.fromUri(Uri.parse(targetPath)).openWrite(
                                    mode: FileMode.write)
                                  ..writeln(
                                    json.encode(
                                      tmp,
                                    ),
                                  )
                                  ..close().then(
                                      (val) => completer.complete(tmp),
                                      onError: (e) => completer.complete(
                                          {})); // if file path is given for writing data into it, and operation is unsuccessful, a blank map will be returned
                              } on Exception {
                                completer.complete(
                                    {}); // in case of exception, will return a blank map
                              }
                            else
                              completer.complete(tmp);
                          },
                          onError: (e) => completer.complete({}),
                        );
                      },
                      onError: (e) => completer.complete({}),
                    );
                  },
                  onError: (e) => completer.complete({}),
                );
              },
              onError: (e) => completer.complete({}),
            );
          },
          onError: (e) => completer.complete({}),
        );
      },
      onError: (e) => completer.complete({}),
    );
    return completer.future;
  }
}
