import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'common_widgets_barrel.dart';

class RoutingErrorPage extends StatelessWidget {
  final GoRouterState goRouterState;
  const RoutingErrorPage({super.key, required this.goRouterState});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "There was an issue experienced while accessing the next screen kindly contact the customer support.",
            textAlign: TextAlign.center,
            color: theme.hintColor,
          ),
        ],
      ),
    );
  }
}
