import 'package:country_io/country_io.dart';

main() => Generator(
        './data.json') // make sure this path exists, otherwise operation will fail, by returning false
    .generate()
    .then((result) => print(result ? 'Success' : 'Failed !!!'));
