import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;

  const GradientButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(26, 46, 73, 1),
          shadowColor: Colors.black.withOpacity(0.7),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Color.fromRGBO(26, 46, 73, 1))),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
