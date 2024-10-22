import 'package:flutter/material.dart';
import 'package:zehadis/buttons.dart';
import 'package:zehadis/commen/addDataForm.dart';
import 'package:zehadis/my_drawer.dart';
// import 'package:zehadis/commen/gradientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> churchCounts = {};
  bool isLoading = true;

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
    'Kality',
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
  void initState() {
    super.initState();
    fetchChurchCounts();
  }

  int _selectedIndex = 0;

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  Future<void> fetchChurchCounts() async {
    try {
      for (String subCity in names) {
        // Fetch the count for each SubCity from Firestore
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('churches')
            .where('SubCity', isEqualTo: subCity)
            .get();

        // Update the map with the count
        setState(() {
          churchCounts[subCity] = snapshot.docs.length;
        });
      }
    } catch (e) {
      print("Error fetching church data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
        backgroundColor: Colors.green,
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
              color:
                  Colors.grey.withOpacity(0.5), // Black color with 50% opacity
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Scrollable image at the top
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/Medhanealem.jpg', // Path to your local image
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      // Scrollable list of gradient buttons
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two buttons per row
                            childAspectRatio: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: names.length, // Number of buttons
                          itemBuilder: (context, index) {
                            String subCity = names[index];
                            int count = churchCounts[subCity] ?? 0;

                            return GradientButton(
                                text:
                                    '$subCity', // Display the SubCity and count
                                route: routnames[index],
                                imageUrl: imageg[index],
                                count: count);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddDataForm(), // Display the form widget
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Statics'),
        ],
        selectedItemColor: Colors.green,
        currentIndex:  _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
