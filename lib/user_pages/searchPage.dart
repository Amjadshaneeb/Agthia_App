import 'package:agthia_slot_booking/widgets/textField.dart';
import 'package:flutter/material.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10,),
          Mytextfield(
            obscure: false,
            hinttext: "Search here", icon: Icon(Icons.search))
        ],
      )),
    );
  }
}
