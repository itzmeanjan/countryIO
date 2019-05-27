# countryIO
A simple country.io data parser, written with :heart: using Dart :)

Show some :heart: by putting :star: :)

## what does it do ?
This Dart package can be used to fetch country data from country.io, including *country iso2 code*, *country name*, *capital name*, *continent code*, *currency code* & *phone code*, which will be eventually stored in a json encoded file, whose path needs to be provided to `Generator` class constructor.

##  how to use ?
Well using this package for generating json encoded file, holding country data, is pretty much easy.

Simply invoke `Generator` constructor with a valid path to target `data.json` file. Calling `Generator( ... ).generate()`, will start fetching data from country.io, then parsing data and json encoding data for storing in target file.

This function will return a `Future<bool>`, to denote success or failure of operation.

```dart
Generator('./data.json')
    .generate()
    .then((result) => print(result ? 'Success' : 'Failed !!!'));
```

Yes, it's that simple :wink:

## courtesy
Country data is fetched from country.io, so they do deserve courtesy.

For **T&C** of data utilization, you may be interested in taking a look at country.io

Hoping, it helped you a bit (o_o)
