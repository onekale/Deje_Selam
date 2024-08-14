import 'package:flutter/material.dart';
import 'package:zehadis/buttons.dart';
import 'package:zehadis/my_drawer.dart';

class HomePageMean extends StatelessWidget {
  final List<String> names = [
    'Addis Abeba',
    'Dire Dawa',
    'Debre Markos',
    'Jimma',
    'Debre Birhan',
    'Bahir Dare',
    'Harere',
    'Mekele',
  ];

  final List<String> routeNames = [
    '/Addis',
    '/Dire',
    '/Markos',
    '/jimma',
    '/Birhan',
    '/Harer',
    '/Mekele'
  ];

     final List<String> imageg = [
    'assets/home.jpg', 
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg',
    'assets/home.jpg','assets/home.jpg',
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
      body: Stack(children: [
        // Background image with opacity
        Opacity(
          //Adjesting th Opacity
          opacity: 0.3, 
          child: Image.asset(
            'assets/lalibela2.jpg', // Background image path
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
        Column(
          children: [
            // Non-scrollable image at the top
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(20), // Adjust the radius as needed
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              clipBehavior: Clip
                  .antiAlias, // Ensures the image is clipped within the rounded corners
              child: Image.asset(
                'assets/Medhanealem.jpg', // Path to your local image
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Adjust the height as needed
              ),
            ),
            // Scrollable list of gradient buttons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two buttons per row
                    childAspectRatio:
                        2, // Adjust the aspect ratio to make buttons wider
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: 10, // Number of buttons
                  itemBuilder: (context, index) {
                    return GradientButton(
                      text: names[index],
                      route: routeNames[index],
                      imageUrl: imageg[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ]),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Statics')
      ]),
    );
  }
}
