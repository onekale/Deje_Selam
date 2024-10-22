import 'package:flutter/material.dart';
import 'package:zehadis/commen/addDataForm.dart';
import 'package:zehadis/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountrySelectionPage extends StatelessWidget {
  final List<String> countries = [
    'Addis Abeba',
    'Debre Markos',
    'Dire Dawa',
    'Bahire Dard',
    'Gonder',
    'Debre Tabaor',
    'Bure',
    'Mekele'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deje Selame',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[700],
        elevation: 0,
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.green[800]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.greenAccent[100],
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomePage(country: countries[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.green[50]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: Colors.green[900],
                          size: 28,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            countries[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green[900],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String country;
  HomePage({required this.country});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> churchCounts = {};
  bool isLoading = true;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    'assets/kolfeKeraniyo.jpg',
    'assets/CMC_Michael.jpg',
    'assets/Medhanealem.jpg',
    'assets/yeka.png',
    'assets/adisketam.jpeg',
    'assets/lideta.jpg',
    'assets/egziabherAb.jpg',
    'assets/lafto.jpg',
    'assets/kirkos.png',
    'assets/kality.jpg',
  ];

  @override
  void initState() {
    super.initState();
    fetchChurchCounts();
  }

  Future<void> fetchChurchCounts() async {
    try {
      for (String subCity in names) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('churches')
            .where('SubCity', isEqualTo: subCity)
            .get();

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
            'Churches in ${widget.country}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              'assets/home.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/Medhanealem.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: names.length,
                          itemBuilder: (context, index) {
                            String subCity = names[index];
                            int count = churchCounts[subCity] ?? 0;

                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, routnames[index]);
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(15)),
                                        child: Image.asset(
                                          imageg[index],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              subCity,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '$count Churches',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddDataForm(),
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
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Statistics'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:zehadis/buttons.dart';
// import 'package:zehadis/commen/addDataForm.dart';
// import 'package:zehadis/my_drawer.dart';
// // import 'package:zehadis/commen/gradientButton.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Map<String, int> churchCounts = {};
//   bool isLoading = true;

//   final List<String> names = [
//     'Kolefe',
//     'Lemi Kura',
//     'Bole',
//     'Yeka',
//     'Addis Ketma',
//     'Ledeta',
//     'Guleli',
//     'Lafto',
//     'Kirkos',
//     'Kality',
//   ];


//   final List<String> routnames = [
//     '/kolefe',
//     '/lemi',
//     '/bole',
//     '/yeka',
//     '/addis',
//     '/ledeta',
//     '/guleli',
//     '/lafto',
//     '/kirkos',
//     '/kality',
//   ];

//   final List<String> imageg = [
//     'assets/kolfeKeraniyo.jpg',
//     'assets/CMC_Michael.jpg',
//     'assets/Medhanealem.jpg',
//     'assets/yeka.png',
//     'assets/adisketam.jpeg',
//     'assets/lideta.jpg',
//     'assets/egziabherAb.jpg',
//     'assets/lafto.jpg',
//     'assets/kirkos.png',
//     'assets/kality.jpg',
//   ];


//   @override
//   void initState() {
//     super.initState();
//     fetchChurchCounts();
//   }

//   int _selectedIndex = 0;

// void _onItemTapped(int index) {
//   setState(() {
//     _selectedIndex = index;
//   });
// }

//   Future<void> fetchChurchCounts() async {
//     try {
//       for (String subCity in names) {
//         // Fetch the count for each SubCity from Firestore
//         QuerySnapshot snapshot = await FirebaseFirestore.instance
//             .collection('churches')
//             .where('SubCity', isEqualTo: subCity)
//             .get();

//         // Update the map with the count
//         setState(() {
//           churchCounts[subCity] = snapshot.docs.length;
//         });
//       }
//     } catch (e) {
//       print("Error fetching church data: $e");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             'Get Deje Selame',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         backgroundColor: Colors.green,
//         elevation: 0,
//       ),
//       drawer: MyDrawer(),
//       body: Stack(
//         children: [
//           // Background image with opacity
//           Opacity(
//             opacity: 0.3,
//             child: Image.asset(
//               'assets/home.jpg',
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.5),
//             ),
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           isLoading
//               ? Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // Scrollable image at the top
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20),
//                           ),
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Image.asset(
//                           'assets/Medhanealem.jpg',
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 200,
//                         ),
//                       ),
//                       // Grid of cards with information
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GridView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2, // Two cards per row
//                             childAspectRatio: 1.5,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 15,
//                           ),
//                           itemCount: names.length,
//                           itemBuilder: (context, index) {
//                             String subCity = names[index];
//                             int count = churchCounts[subCity] ?? 0;

//                             return InkWell(
//                               onTap: () {
//                                 Navigator.pushNamed(context, routnames[index]);
//                               },
//                               child: Card(
//                                 elevation: 4,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Expanded(
//                                       flex: 3,
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.vertical(
//                                             top: Radius.circular(15)),
//                                         child: Image.asset(
//                                           imageg[index],
//                                           fit: BoxFit.cover,
//                                           width: double.infinity,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(4.0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               subCity,
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             Text(
//                                               '$count Churches',
//                                               style:
//                                                   TextStyle(color: Colors.grey),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.green,
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             builder: (BuildContext context) {
//               return Padding(
//                 padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).viewInsets.bottom,
//                 ),
//                 child: AddDataForm(), // Display the form widget
//               );
//             },
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//           BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Statics'),
//         ],
//         selectedItemColor: Colors.green,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }