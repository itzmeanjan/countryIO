import 'package:country_io/country_io.dart';

main() => Generator(
        targetPath:
            '../data/data.json') // make sure this path exists i.e. file may not exists, which can be created but you need to have directory already existing, otherwise operation will fail, by returning false
    // if you're not interested in storing it in any file, simply don't pass any argument for targetPath parameter
    .generate()
    .then((result) => print(result.isNotEmpty ? 'Success' : 'Failed !!!'));
