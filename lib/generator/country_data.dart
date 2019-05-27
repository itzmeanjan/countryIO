/// Holds data regarding a certain country, which is uniquely identified using iso2 code
class CountryData {
  String iso2;
  String continent;
  String name;
  String iso3;
  String capital;
  String phone;
  String currency;
  CountryData(this.iso2);

  /// Returns country data in proper format, which will be used to put into target json file
  ///
  /// If country identifier iso2 code is null, returns a empty Map
  Map<String, Map<String, String>> getData() =>
      iso2 == null ? {} : {iso2: getCountryDetails()};

  /// Returns this country details in Map<String, String> format
  Map<String, String> getCountryDetails() => {
        'continent': continent ?? '',
        'name': name ?? '',
        'iso3': iso3 ?? '',
        'capital': capital ?? '',
        'phone': phone ?? '',
        'currency': currency ?? '',
      };
}
