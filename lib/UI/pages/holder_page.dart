import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home_page.dart';


class HolderPage extends StatelessWidget {
  static const routeName = '/holderPage';
  const HolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: HomePage(),
    ));
  }
}
