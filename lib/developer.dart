import 'package:flutter/material.dart';

class Developer extends StatelessWidget {
  Developer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text('DEVELOPER',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          backgroundColor: Colors.grey.withOpacity(0.5),
          elevation: 0,
        ),
        body: Stack(children: [
          Opacity(
            opacity: 0.3, // Adjust opacity as needed
            child: Image.asset(
              'assets/home.jpg', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey
                    .withOpacity(0.5), // Black color with 50% opacity
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                //profile pic
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(26, 46, 73, 1),
                      borderRadius: BorderRadius.circular(24)),
                  padding: const EdgeInsets.all(25),
                  child: const Icon(Icons.person, size: 64, color: Colors.grey),
                ),

                const SizedBox(
                  height: 25,
                ),
                //usename
                Text(
                  'KALEAB SHEWNAHE',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(26, 46, 73, 1)),
                ),

                //email
                Text(
                  '4th YEAR SOFTWARE ENGINNERING',
                  style: TextStyle(
                      color: Color.fromRGBO(26, 46, 73, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.email),
                Text('kaleshewnahe@gmail.com',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w100))
              ],
            ),
          ),
        ]));
  }
}
