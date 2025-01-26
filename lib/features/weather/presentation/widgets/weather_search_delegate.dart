import 'package:flutter/material.dart';
import 'package:weather_app/core/values/values_barrel.dart';

import '../../../../core/core_barrel.dart';

class WeatherSearchDelegate extends SearchCustomDelegate {

   WeatherSearchDelegate() : super(
   searchFieldLabel: "Search for a city",
   // searchFieldStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w200),
   searchFieldDecorationTheme: InputDecorationTheme(
     fillColor: Colors.white,
     filled: true,
     hintStyle: TextStyle(
         color: Colors.black.withOpacity(0.2),
         fontWeight: FontWeight.w300,
         fontSize: 14.0,
         fontFamily: 'Laila'),
     border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(8),
         borderSide: const BorderSide(
             color: primaryColor,
             width: 1)),
     enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(8),
         borderSide: const BorderSide(
             color: primaryColor,
             width: 1)),
     focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(8),
         borderSide: const BorderSide(
           color: primaryColor,
             width: 1)),
     contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
   ),
   keyboardType: TextInputType.text,
   // textInputAction: TextInputAction.search,
   );

   // @override
   //  ThemeData appBarTheme(BuildContext context) {
   //    return Theme.of(context);
   //  }

    @override
  double? get leadingWidth => 30;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.black,
      icon: const BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("data - Results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("data - Suggestions");
  }
}