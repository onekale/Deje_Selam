import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Kolefe extends StatefulWidget {
  @override
  _kolefeState createState() => _kolefeState();
}

class _kolefeState extends State<Kolefe> {
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
        .where('SubCity', isEqualTo: 'Kolefe')
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
        backgroundColor: Colors.green,
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
                            padding: const EdgeInsets.all(11.0),
                            child: Center(
                              child: Text(
                                itemData['title'] ?? '',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 183, 0, 1),
                                  fontSize: 23,
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
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _launchURL(
                                            itemData['googleMapUrl'] ?? '');
                                      },
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          _launchURL(
                                              itemData['googleMapUrl'] ?? '');
                                        },
                                        icon: Icon(Icons.location_on,
                                            color: Colors.white),
                                        label: Text(
                                          'View',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            backgroundColor: Colors.green,
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 20,
                                                top: 7,
                                                bottom: 7)),
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    // "More Info" or "Show Less" button
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isExpandedList[index] =
                                              !_isExpandedList[index];
                                        });
                                      },
                                      child: ElevatedButton(
                                        onPressed: () {
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
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            backgroundColor: Colors.green,
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 7,
                                                bottom: 7)),
                                      ),
                                    ),
                                  ],
                                ),
                                if (_isExpandedList[index]) ...[
                                  SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[
                                          800], // Background for expanded section
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors
                                              .black26, // Shadow for depth
                                          blurRadius: 6,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.church,
                                                color: Colors.green, size: 20),
                                            SizedBox(width: 8),
                                            Text(
                                              'Name of Ark:',
                                              style: TextStyle(
                                                color: Color.fromRGBO(255, 183,
                                                    0, 1), // Gold color
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                itemData['NameOfArks'] ?? '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Colors
                                                .white38), // Subtle divider
                                        Row(
                                          children: [
                                            Icon(Icons.school,
                                                color: Colors.green, size: 20),
                                            SizedBox(width: 8),
                                            Text(
                                              'Sunday School:',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 183, 0, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                itemData['SundaySchool'] ?? '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(color: Colors.white38),
                                        Row(
                                          children: [
                                            Icon(Icons.description,
                                                color: Colors.green, size: 20),
                                            SizedBox(width: 8),
                                            Text(
                                              'Description:',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 183, 0, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                itemData['description'] ?? '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(color: Colors.white38),
                                        Row(
                                          children: [
                                            Icon(Icons.date_range,
                                                color: Colors.green, size: 20),
                                            SizedBox(width: 8),
                                            Text(
                                              'Date:',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 183, 0, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                itemData['Date'] ?? '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
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
        selectedItemColor: Colors.green[700],
      ),
    );
  }
}
