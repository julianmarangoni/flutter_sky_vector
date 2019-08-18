import 'package:flutter_test/flutter_test.dart';

import 'package:sky_vector/sky_vector.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'dart:math';


void main() async {

  List<String> countries = await SkyVector.countries();

  print('Countries:');

  for (var country in countries) {

    print(country);
    test('adds one to input values', () {
    expect(country, isNot(''));
    });

  }

  String selectedCountry = countries[new Random().nextInt(countries.length)];

  //selectedCountry = 'Canada';

  print('---------------------------------------');
  print('Seleced Random Country: $selectedCountry');
  print('---------------------------------------');

  List<String> regions = await SkyVector.regions(selectedCountry);

  print('Regions:');


  for (var region in regions) {

    print(region);

    test('adds one to input values', () {
      expect(region, isNot(''));
    });

  }

  String selectedRegion = regions[new Random().nextInt(regions.length)];

  print('---------------------------------------');
  print('Seleced Random Region: $selectedRegion');
  print('---------------------------------------');

  List<Element> airports = await SkyVector.airports(selectedCountry, selectedRegion);

  print('Airports:');

  for (var airport in airports) {

    print(airport.getElementsByTagName('a').first.text);

    test('adds one to input values', () {
      expect(airport.getElementsByTagName('a').first.text, isNot('About Us'));
      expect(airport.getElementsByTagName('a').first.text, isNot('Login'));
      expect(airport.getElementsByTagName('a').first.text.length, isNot(0));
    });

  }

  var randomAirport = airports[new Random().nextInt(airports.length)];

  print('---------------------------------------');
  print('Seleced Random Airport: ${randomAirport.getElementsByTagName('a').first.text}');
  print('---------------------------------------');

  List<String> airportSectionsList = await SkyVector.airportDetails(randomAirport.getElementsByTagName('a').first.attributes['href']);

  print('Airport Sections:');

  for (var airportSection in airportSectionsList) {

    print(airportSection);

  }

  var selectedSection = airportSectionsList[new Random().nextInt(airportSectionsList.length)];

  print('---------------------------------------');
  print('Seleced Random Section: $selectedSection');
  print('---------------------------------------');

  var section = await SkyVector.airportSection(randomAirport.getElementsByTagName('a').first.attributes['href'], selectedSection);

}
