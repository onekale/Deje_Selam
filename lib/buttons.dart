import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final String route;
  final String imageUrl;
   final int count;

  const GradientButton({
    Key? key,
    required this.text,
    required this.route,
    required this.imageUrl,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: double.infinity, // Adjust as needed
        height: 200, // Adjust as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imageUrl), // Use NetworkImage or AssetImage
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            // Button with text
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.transparent, // Transparent background 
                  shadowColor: Colors.transparent, // No shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    // side: BorderSide(color: Color.fromRGBO(26, 46, 73, 1)),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, route);
                },
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
                        Positioned(
              bottom: 10, // Adjust as needed
              left: 140, // Adjust as needed
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count', // Display the count
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
