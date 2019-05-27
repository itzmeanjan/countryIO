import 'package:country_io/country_io.dart';

main() {
  Continent().fetch().then((data) {
    if (data.isNotEmpty)
      data.forEach(
        (key, value) => print('$key -- $value'),
      );
    else
      print('No data');
  });
}
