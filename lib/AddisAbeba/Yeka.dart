// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Yeka extends StatelessWidget {
//   final List<Map<String, String>> items = [
//     {
//       'image': 'assets/Medhanealem.jpg',
//       'title': 'ቦሌ መድኃኒዓለም',
//       'description': 'ደብረ ሳሌም መድኃኒዓለም ቤተ ክርስቲያን',
//       'url':
//           'https://www.google.com/maps/place/Sealite+Mihret+Church/@9.0194616,38.8274434,16.95z/data=!4m6!3m5!1s0x164b9ab1469251e9:0x3a5e2387af070799!8m2!3d9.0189796!4d38.8285844!16s%2Fg%2F11hbvplxl5?entry=ttu'
//     }
//     // Add more items as needed
//   ];

//   Future<void> _launchURL(String url) async {
//     // Ensure the URL can be launched
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return Container(
//               margin: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[850],
//                 borderRadius: BorderRadius.circular(10),
//                 border:
//                     Border.all(color: Color.fromRGBO(0, 255, 240, 1), width: 2),
//               ),
//               child: Column(
//                 children: [
//                   // Image at the top
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     ),
//                     child: Image.asset(
//                       items[index]['image']!, // Path to the image
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: 200, // Adjust the height as needed
//                     ),
//                   ),
//                   // Text title
//                   Padding(
//                     padding: const EdgeInsets.all(13.0),
//                     child: Center(
//                       child: Text(
//                         items[index]['title']!, // Description text
//                         style: TextStyle(
//                             color: Color.fromRGBO(0, 255, 240, 1),
//                             fontSize: 21,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   // Text description at the bottom
//                   Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: Text(
//                       items[index]['description']!, // Description text
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ]),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zehadis/commen/addDataForm.dart';

class Yeka extends StatefulWidget {
  @override
  _YekaState createState() => _YekaState();
}

class _YekaState extends State<Yeka> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> items = [];
  List<bool> _isExpandedList = [];

  @override
  void initState() {
    super.initState();
    fetchItemsFromFirebase();
  }

  // Fetch data from Firebase Firestore
  void fetchItemsFromFirebase() async {
    QuerySnapshot snapshot = await _firestore
        .collection('churches')
        .where('SubCity', isEqualTo: 'Yeka')
        .get();
    setState(() {
      items = snapshot.docs;
      _isExpandedList = List.generate(items.length, (index) => false);
    });
  }

  // Launch URL function
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'AddisAbeba/LemiKura',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(0.5),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              'assets/Medhanealem.jpg',
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
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var itemData = items[index].data() as Map<String, dynamic>;
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              itemData['imageUrl'] ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Center(
                              child: Text(
                                itemData['title'] ?? '',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 255, 240, 1),
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    itemData['Name'] ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(itemData['googleMapUrl'] ?? '');
                                  },
                                  child: Text(
                                    'View on Google Maps',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isExpandedList[index] =
                                          !_isExpandedList[index];
                                    });
                                  },
                                  child: Text(
                                    _isExpandedList[index]
                                        ? 'Show Less'
                                        : 'More Info',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                if (_isExpandedList[index]) ...[
                                  SizedBox(height: 10),
                                  Text(
                                    'Name of Ark: ${itemData['NameOfArks'] ?? ''}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'SundaySchool: ${itemData['SundaySchool'] ?? ''}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Description: ${itemData['description'] ?? ''}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Date: ${itemData['Date'] ?? ''}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
