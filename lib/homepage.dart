import 'package:flutter/material.dart';
import 'package:zehadis/buttons.dart';
import 'package:zehadis/my_drawer.dart';

class HomePage extends StatelessWidget {

  final List<String> names = [
    'Kolefe',
    'Lemi Kura',
    'Bole',
    'Yeka',
    'Addis Ketma',
    'Ledeta',
    'Guleli',
    'Lafto',
    'Kirkos',
    'Kality'
  ];

  final List<String> routnames = [
    '/kolefe',
    '/lemi',
    '/bole',
    '/yeka',
    '/addis',
    '/ledeta',
    '/guleli',
    '/lafto',
    '/kirkos',
    '/kality',

  ];

    final List<String> imageg = [
    'assets/home.jpg', 
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Get Deje Selame',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(0.5),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () => {},
        //   icon: Icon(Icons.menu),
        // ),
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          // Background image with opacity
          Opacity(
            opacity: 0.3, // Adjust opacity as needed
            child: Image.asset(
              'assets/home.jpg', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5), // Black color with 50% opacity
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Scrollable image at the top
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20), // Adjust the radius as needed
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias, // Ensures the image is clipped within the rounded corners
                  child: Image.asset(
                    'assets/Medhanealem.jpg', // Path to your local image
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200, // Adjust the height as needed
                  ),
                ),
                // Scrollable list of gradient buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true, // Makes sure the GridView takes up only the necessary height
                    physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two buttons per row
                      childAspectRatio: 2, // Adjust the aspect ratio to make buttons wider
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: names.length, // Number of buttons
                    itemBuilder: (context, index) {
                      return GradientButton(
                        text: names[index],
                        route: routnames[index],
                        imageUrl: imageg[index],

                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Statics'),
        ],
      ),
    );
  }
}
