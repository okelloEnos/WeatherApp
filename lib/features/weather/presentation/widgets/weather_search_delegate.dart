import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/values/values_barrel.dart';

import '../../../../core/core_barrel.dart';
import '../../../features_barrel.dart';

class WeatherSearchDelegate extends SearchCustomDelegate<CityEntity?> {

   WeatherSearchDelegate() : super(
   searchFieldLabel: "Search for a city",
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
   );

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

     _onQueryChanged(query, (searchTerm) {
       context.read<SearchBloc>().add(FetchCityListEvent(query: searchTerm));
     });

     return BlocBuilder<SearchBloc, SearchState>(
       builder: (context, state) {
         if (query.isEmpty) {
           return Center(
             child: CustomText(text: "Type to see suggestions.", color: Theme.of(context).colorScheme.onPrimary, fontSize: 14.0,),
           );
         }

         if (state is SearchLoaded && state.cities.isNotEmpty) {
           final suggestions = state.cities.take(5).toList();

           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             child: ListView.separated(
               separatorBuilder: (context, index) => const SizedBox(height: 8.0),
               itemCount: suggestions.length,
               itemBuilder: (context, index) {
                 final suggestion = suggestions[index];
                 return GestureDetector(
                   child: Container(
                       padding: const EdgeInsets.all(8.0),
                       decoration: BoxDecoration(
                         color: Theme.of(context).colorScheme.onPrimary,
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: CustomText(text: suggestion.name ?? "", color: Theme.of(context).colorScheme.primary, fontSize: 14.0, fontWeight: FontWeight.w500,)),
                   onTap: () {
                     query = suggestion.name ?? "";
                     close(context, suggestion);
                   },
                 );
               },
             ),
           );
         }
         return Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
           child: ListView.separated(
             separatorBuilder: (context, index) => const SizedBox(height: 8.0),
             itemCount: 4,
             itemBuilder: (context, index) {
               return const ShimmerContainer(
                   width: double.infinity,
                   borderRadius: 8.0,
                   height: 40);
             },
           ),
         );
       },
     );
   }

   @override
   Widget buildSuggestions(BuildContext context) {
     _onQueryChanged(query, (searchTerm) {
       context.read<SearchBloc>().add(FetchCityListEvent(query: searchTerm));
     });

     return BlocBuilder<SearchBloc, SearchState>(
       builder: (context, state) {
         if (query.isEmpty) {
           return Center(
             child: CustomText(text: "Type to see suggestions.", color: Theme.of(context).colorScheme.onPrimary, fontSize: 14.0,),
           );
         }

         if (state is SearchLoaded && state.cities.isNotEmpty) {
           final suggestions = state.cities.take(5).toList();

           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             child: ListView.separated(
               separatorBuilder: (context, index) => const SizedBox(height: 8.0),
               itemCount: suggestions.length,
               itemBuilder: (context, index) {
                 final suggestion = suggestions[index];
                 return GestureDetector(
                   child: Container(
                     padding: const EdgeInsets.all(8.0),
                       decoration: BoxDecoration(
                         color: Theme.of(context).colorScheme.onPrimary,
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: CustomText(text: suggestion.name ?? "", color: Theme.of(context).colorScheme.primary, fontSize: 14.0, fontWeight: FontWeight.w500,)),
                   onTap: () {
                     query = suggestion.name ?? "";
                     close(context, suggestion);
                   },
                 );
               },
             ),
           );
         }
         return Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
           child: ListView.separated(
             separatorBuilder: (context, index) => const SizedBox(height: 8.0),
             itemCount: 4,
             itemBuilder: (context, index) {

               return const ShimmerContainer(
                   width: double.infinity,
                   borderRadius: 8.0,
                   height: 40);
             },
           ),
         );
       },
     );
   }

   @override
   void dispose() {
     _debounce?.cancel();
     super.dispose();
   }
}