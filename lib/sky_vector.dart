library sky_vector;

import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class SkyVector {


  Future<List<String>> countries() async {
    var client = Client();
    Response response = await client.get(
        'https://skyvector.com/airports'
    );

    var document = parse(response.body);
    List<Element> countries = document.querySelectorAll('.views-summary.views-summary-unformatted');

    List<String> countriesText = List();


    for (var country in countries) {

      String countryText = country.getElementsByTagName('a').first.text;
      countriesText.add(countryText);
    }

    return countriesText;

  }

  Future<List<String>> regions(String country) async {

    var client = Client();
    Response response = await client.get(
        'https://skyvector.com/airports/$country'
    );

    var document = parse(response.body);
    List<Element> regions = document.querySelectorAll('.views-summary.views-summary-unformatted');

    List<String> regionsList = List();

    for (var region in regions) {

      var r = region.getElementsByTagName('a').first.text;
      regionsList.add(r);


    }

    return regionsList;

  }

  Future<List<Element>> airports(String country,String region) async {

    var client = Client();
    Response response = await client.get(
        'https://skyvector.com/airports/$country/$region'
    );

    var document = parse(response.body);
    List<Element> airportElements = document.querySelectorAll('.odd, .even');

    airportElements.removeWhere((element) {

    if(element.getElementsByTagName('a').first.text == 'Login' || element.getElementsByTagName('a').first.text == 'About Us' || element.getElementsByTagName('a').first.text.length == 0)
      return true;

      return false;

    });


    return airportElements;

  }

}
