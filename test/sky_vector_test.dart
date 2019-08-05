import 'package:flutter_test/flutter_test.dart';

import 'package:sky_vector/sky_vector.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'dart:math';


void main() async {

  final SkyVector skyVector = new SkyVector();

  List<String> countries = await skyVector.countries();

  for (var country in countries) {

    test('adds one to input values', () {
    expect(country, isNot(''));
    });

  }

  String selectedCountry = countries[new Random().nextInt(countries.length)];

  print('Seleced Random Country: $selectedCountry');
  print('---------------------------------------');

  List<String> regions = await skyVector.regions(selectedCountry);

  for (var region in regions) {

    print(region);

    test('adds one to input values', () {
      expect(region, isNot(''));
    });

  }

  String selectedRegion = regions[new Random().nextInt(regions.length)];

  print('---------------------------------------');
  print('Seleced Random Region: $selectedRegion');

  List<Element> airports = await skyVector.airports(selectedCountry, selectedRegion);

  for (var airport in airports) {

    print(airport.getElementsByTagName('a').first.text);

   //print(airport.getElementsByTagName('a').first.attributes['href']);
    test('adds one to input values', () {
      expect(airport.getElementsByTagName('a').first.text, isNot('About Us'));
      expect(airport.getElementsByTagName('a').first.text, isNot('Login'));
      expect(airport.getElementsByTagName('a').first.text.length, isNot(0));
    });

  }

}
