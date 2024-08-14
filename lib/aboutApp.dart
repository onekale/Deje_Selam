import 'package:flutter/material.dart';

class Aboutapp extends StatelessWidget {
  Aboutapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(
              child: Text(
                'About the App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Colors.grey.withOpacity(0.5)),
        body: Stack(
          children: [
            Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/home.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )),
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
                    child:
                        const Icon(Icons.person, size: 64, color: Colors.grey),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Center(
                      child: Text(
                    'This application is a page where you can find the Orthodox Tewahedo Church in Ethiopia from the past and the current churches with their complete information.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(26, 46, 73, 1),
                    ),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
