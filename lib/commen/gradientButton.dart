import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final String route;
  final String imageUrl;
  final int count; // New parameter for count

  const GradientButton({
    Key? key,
    required this.text,
    required this.route,
    required this.imageUrl,
    required this.count, // Accept count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your gradient background here
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imageUrl, height: 50), // Example image
                SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count Churches',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}