import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f172b),
      appBar: AppBar(),
      body: const Column(
        children: [
          Center(
            child: Hero(
                tag: "call",
                child: Icon(
                  Icons.call_sharp,
                  color: Colors.white,
                )),
          ),
          Hero(
              tag: "Text",
              child: Text(
                "cfgvhb",
                
                style: TextStyle(color: Colors.white,fontSize: 30),
              )),
        ],
      ),
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final Duration duration;

  CustomPageRoute({required this.builder, required this.duration})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionDuration: duration, 
        );
}