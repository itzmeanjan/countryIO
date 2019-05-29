import 'package:country_io/country_io.dart';

main() => Generator(
        '../data/data.json') // make sure this path exists i.e. file may not exists, which can be created but you need to have directory already existing, otherwise operation will fail, by returning false
    .generate()
    .then((result) => print(result.isNotEmpty ? 'Success' : 'Failed !!!'));
