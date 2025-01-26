import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/values/values_barrel.dart';

import '../../../../core/core_barrel.dart';
import '../../../features_barrel.dart';

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

   Timer? _debounce;

   void _onQueryChanged(String newQuery, Function(String) onSearch) {
     if (_debounce?.isActive ?? false) _debounce!.cancel();
     _debounce = Timer(const Duration(milliseconds: 500), () {
       if (newQuery.isNotEmpty) {
         onSearch(newQuery);
       }
     });
   }

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

  // @override
  // Widget buildResults(BuildContext context) {
  //   return Text("data - Results");
  // }
  //
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   return Text("data - Suggestions");
  // }
///
   // @override
   // Widget buildResults(BuildContext context) {
   //   if (query.length < 3) {
   //     return Column(
   //       mainAxisAlignment: MainAxisAlignment.center,
   //       children: <Widget>[
   //         Center(
   //           child: Text(
   //             "Search term must be longer than two letters.",
   //           ),
   //         )
   //       ],
   //     );
   //   }
   //
   //   //Add the search term to the searchBloc.
   //   //The Bloc will then handle the searching and add the results to the searchResults stream.
   //   //This is the equivalent of submitting the search term to whatever search service you are using
   //   // InheritedBlocs.of(context)
   //   //     .searchBloc
   //   //     .searchTerm
   //   //     .add(query);
   //
   //   return Column(
   //     children: <Widget>[
   //       //Build the results based on the searchResults stream in the searchBloc
   //       // StreamBuilder(
   //       //   stream: InheritedBlocs.of(context).searchBloc.searchResults,
   //       //   builder: (context, AsyncSnapshot<List<Result>> snapshot) {
   //       //     if (!snapshot.hasData) {
   //       //       return Column(
   //       //         crossAxisAlignment: CrossAxisAlignment.center,
   //       //         mainAxisAlignment: MainAxisAlignment.center,
   //       //         children: <Widget>[
   //       //           Center(child: CircularProgressIndicator()),
   //       //         ],
   //       //       );
   //       //     } else if (snapshot.data.length == 0) {
   //       //       return Column(
   //       //         children: <Widget>[
   //       //           Text(
   //       //             "No Results Found.",
   //       //           ),
   //       //         ],
   //       //       );
   //       //     } else {
   //       //       var results = snapshot.data;
   //       //       return ListView.builder(
   //       //         itemCount: results.length,
   //       //         itemBuilder: (context, index) {
   //       //           var result = results[index];
   //       //           return ListTile(
   //       //             title: Text(result.title),
   //       //           );
   //       //         },
   //       //       );
   //       //     }
   //       //   },
   //       // ),
   //     ],
   //   );
   // }
   //
   // @override
   // Widget buildSuggestions(BuildContext context) {
   //   // This method is called everytime the search term changes.
   //   // If you want to add search suggestions as the user enters their search term, this is the place to do that.
   //   return Column();
   // }

   @override
   Widget buildResults(BuildContext context) {
     if (query.trim().isEmpty || query.trim().length < 3) {
       return Center(
         child: Text(
           "Search term must be at least three characters.",
           style: TextStyle(color: Colors.grey),
         ),
       );
     }

     // Add the search query to the Bloc when the user types
     _onQueryChanged(query, (searchTerm) {
       context.read<SearchBloc>().add(FetchCityListEvent(query: searchTerm));
     });

     return BlocBuilder<SearchBloc, SearchState>(
       builder: (context, state) {
         if (state is SearchLoading) {
           return Center(
             child: CircularProgressIndicator(),
           );
         } else if (state is SearchLoaded) {
           if (state.cities.isEmpty) {
             return Center(
               child: Text(
                 "No Results Found.",
                 style: TextStyle(color: Colors.grey),
               ),
             );
           }
           return ListView.builder(
             itemCount: state.cities.length,
             itemBuilder: (context, index) {
               final result = state.cities[index];
               return ListTile(
                 title: Text(result.cityName),
                 subtitle: Text(result.country),
                 onTap: () {
                   // Handle navigation or actions when a result is tapped
                 },
               );
             },
           );
         } else if (state is SearchError) {
           return Center(
             child: Text(
               "An error occurred. Please try again.",
               style: TextStyle(color: Colors.red),
             ),
           );
         }
         return Center(
           child: Text("Start typing to see results."),
         );
       },
     );
   }

   @override
   Widget buildSuggestions(BuildContext context) {
     // Add debouncing for suggestions if needed
     _onQueryChanged(query, (searchTerm) {
       context.read<SearchBloc>().add(FetchCityListEvent(query: searchTerm));
     });

     return BlocBuilder<SearchBloc, SearchState>(
       builder: (context, state) {
         if (query.isEmpty) {
           return Center(
             child: Text(
               "Type to see suggestions.",
               style: TextStyle(color: Colors.grey),
             ),
           );
         }

         if (state is SearchLoaded && state.cities.isNotEmpty) {
           final suggestions = state.cities.take(5).toList(); // Limit to 5 suggestions
           return ListView.builder(
             itemCount: suggestions.length,
             itemBuilder: (context, index) {
               final suggestion = suggestions[index];
               return ListTile(
                 title: Text(suggestion.cityName),
                 onTap: () {
                   query = suggestion.cityName;
                   showResults(context); // Triggers buildResults
                 },
               );
             },
           );
         }
         return Center(child: CircularProgressIndicator());
       },
     );
   }

   @override
   void dispose() {
     _debounce?.cancel();
     super.dispose();
   }
}