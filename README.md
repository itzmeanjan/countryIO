# countryIO
A simple country.io data parser, written with :heart: using Dart :)

Show some :heart: by putting :star: :)

**This plugin is readily available for [use](https://pub.dev/packages/country_io).** ... :running: ...

## what does it do ?
This *Dart* package can be used to fetch country data from [country.io](http://country.io/), which includes *country iso2 code*, *country name*, *capital name*, *continent code*, *currency code* & *phone code*, which will be eventually stored in a json encoded file, whose path needs to be provided to `Generator` class constructor.

##  how to use ?
Well using this package for generating json encoded file, holding country data, is pretty much easy.

Simply invoke `Generator` constructor with a valid path to target `data.json` file. Calling `Generator( ... ).generate()`, will start fetching data from country.io, then parsing data and json encoding data for storing in target file.

This function will return a `Future<Map<String, Map<String, String>>>`, an empty Map denotes failure, otherwise full parsed data set will be returned in form of Map.

Every key of this map will be an iso2 country code, helping to identify a certain country uniquely.
```dart
{
     .
     .
     .
     iso2:
     {
        'continent': continent ?? '',
        'name': name ?? '',
        'iso3': iso3 ?? '',
        'capital': capital ?? '',
        'phone': phone ?? '',
        'currency': currency ?? '',
      }
     .
     .
     .
   }
```
And value for a certain iso2 country code will be another `Map<String, String>`, holding detailed country info.

```dart
Generator('./data.json')
    .generate()
    .then((result) => print(result.isNotEmpty ? 'Success' : 'Failed !!!'));
```

Yes, it's that simple :wink:

## courtesy
Country data is fetched from [country.io](http://country.io/data/), so they do deserve courtesy.

For **T&C** of data utilization, you may be interested in taking a look at [country.io](http://country.io/)

Hoping, it helped you a bit (o_o)
