import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zehadis/commen/addDataForm.dart';

class Lemikura extends StatefulWidget {
  @override
  _LemikuraState createState() => _LemikuraState();
}

class _LemikuraState extends State<Lemikura> {
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
    QuerySnapshot snapshot = await _firestore.collection('churches').where('SubCity', isEqualTo: 'Lemi Kura').get();
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

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Lemikura extends StatefulWidget {
//   @override
//   _LemikuraState createState() => _LemikuraState();

// }


// class _LemikuraState extends State<Lemikura> {

// final List<Map<String, dynamic>> items = [
//   {
//     'image': 'assets/Medhanealem.jpg',
//     'title': 'ሰዓሊተ ምህረት',
//     'description': 'ደብረ ምጥማቅ ሰዓሊተ ምሕረት ቅድስት ማርያም ወቅድስት ክርስቶስ ሠምራ ቤተ ክርስቲያን',
//     'url': 'https://www.google.com',
//     'more': {
//       'name': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh',
//       'number of church': 'na',
//       'created time': '2024/3/2',
//     }
//   },
// ];


//  List<bool> _isExpandedList = [];

//   @override
//   void initState() {
//     super.initState();
//     _isExpandedList = List.generate(items.length, (index) => false);
//   }

//   Future<void> _launchURL(String url) async {
//     try {
//       if (await canLaunch(url)) {
//         await launch(url);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print('Error launching URL: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('AddisAbeba/LemiKura', style: TextStyle(fontWeight: FontWeight.bold)),
//         ),
//         backgroundColor: Colors.grey.withOpacity(0.5),
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Opacity(
//             opacity: 0.3,
//             child: Image.asset(
//               'assets/Medhanealem.jpg',
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
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[850],
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                       child: Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                             ),
//                             child: Image.asset(
//                               items[index]['image']!,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: 200,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(13.0),
//                             child: Center(
//                               child: Text(
//                                 items[index]['title']!,
//                                 style: TextStyle(
//                                   color: Color.fromRGBO(0, 255, 240, 1),
//                                   fontSize: 21,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     items[index]['description']!,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 GestureDetector(
//                                   onTap: () {
//                                     _launchURL(items[index]['url']!);
//                                   },
//                                   child: Text(
//                                     'Click Me',
//                                     style: TextStyle(
//                                       color: Colors.blue,
//                                       fontSize: 16,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       _isExpandedList[index] = !_isExpandedList[index];
//                                     });
//                                   },
//                                   child: Text(
//                                     _isExpandedList[index] ? 'Show Less' : 'More Info',
//                                     style: TextStyle(
//                                       color: Colors.blue,
//                                       fontSize: 16,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ),
//                                 if (_isExpandedList[index]) ...[
//                                   SizedBox(height: 10),
//                                   Text(
//                                     'Name: ${items[index]['more']['name']}',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Number of Church: ${items[index]['more']['number of church']}',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Created Time: ${items[index]['more']['created time']}',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }


  // final List<Map<String, String>> items = [
  //   {
  //     'image': 'assets/Medhanealem.jpg',
  //     'title': 'ሰዓሊተ ምህረት',
  //     'description': 'ደብረ ምጥማቅ ሰዓሊተ ምሕረት ቅድስት ማርያም ወቅድስት ክርስቶስ ሠምራ ቤተ ክርስቲያን',
  //     'url':
  //         'https://www.google.com',
  //     'more': 'kajs ashdfjahdj ashd /n fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh'
  //   },
  //   {
  //     'image': 'assets/CMC_Michael.jpg',
  //     'title': 'CMC ቅዱስ ሚካኤል',
  //     'description': 'Description for image 2',
  //     'url': 'https://www.google.com/maps?q=location2',
  //     'more': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh '
  //   },
  //   {
  //     'image': 'assets/SemitKdusGiyorgis.jpg',
  //     'title': 'ሰሚት ቅዱስ ጊዮርጊስ',
  //     'description': 'Description for image 3',
  //     'url': 'https://www.google.com/maps?q=location3',
  //     'more': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh '
  //   },
  //   {
  //     'image': 'assets/MeriKedusSelase.jpg',
  //     'title': 'መሪ ቅድስት ሥላሴ',
  //     'description':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
  //     'url':
  //         'https://www.google.com/maps/place/Sealite+Mihret+Church/@9.0194616,38.8274434,16.95z/data=!4m6!3m5!1s0x164b9ab1469251e9:0x3a5e2387af070799!8m2!3d9.0189796!4d38.8285844!16s%2Fg%2F11hbvplxl5?entry=ttu',
  //     'more': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh '
  //   },
  //   {
  //     'image': 'assets/GoroMichael.jpg',
  //     'title': 'ጎሮ ቅዱስ ሚካኤል ቤተ ክርስቲያን',
  //     'description':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
  //     'url':
  //         'https://www.google.com/maps/place/Goro+St.+Michael+Church+%7C+%E1%8C%8E%E1%88%AE+%E1%89%85%E1%8B%B1%E1%88%B5+%E1%88%9A%E1%8A%AB%E1%8A%A4%E1%88%8D+%E1%89%A4%E1%89%B0%E1%8A%AD%E1%88%AD%E1%88%B5%E1%89%B2%E1%8B%AB%E1%8A%95/@8.9961513,38.8314901,17z/data=!4m14!1m7!3m6!1s0x164b9ab1469251e9:0x3a5e2387af070799!2sSealite+Mihret+Church!8m2!3d9.0189796!4d38.8285844!16s%2Fg%2F11hbvplxl5!3m5!1s0x164b9b62ec1605db:0xfd72503544230410!8m2!3d8.9955255!4d38.8324863!16s%2Fg%2F11nnpmw2d1?entry=ttu',
  //     'more': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh '
  //   },
  //   {
  //     'image': 'assets/GoroMichael.jpg',
  //     'title': 'ሰሚት መድኃኒዓለም',
  //     'description': 'መካነ ሰላም ቅዱስ መድኃኒዓለም ቤተ ክርስቲያን',
  //     'url':
  //         'https://www.google.com/maps/place/Semit+Mekane+Selam+Medhanialem+Church/@9.0022911,38.8408558,3a,75y,90t/data=!3m8!1e2!3m6!1sAF1QipMx9WwERAcUj6Klq99ngeOkudeKcWwXAjkx9cwt!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipMx9WwERAcUj6Klq99ngeOkudeKcWwXAjkx9cwt%3Dw152-h86-k-no!7i4032!8i2268!4m16!1m8!3m7!1s0x164b9ab1469251e9:0x3a5e2387af070799!2sSealite+Mihret+Church!8m2!3d9.0189796!4d38.8285844!10e5!16s%2Fg%2F11hbvplxl5!3m6!1s0x164b9ac1fab9c7df:0x3ba7a62b9c6641f7!8m2!3d9.0022911!4d38.8408558!10e5!16s%2Fg%2F1pp2tzkb4?hl=en&entry=ttu',
  //     'more': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh '
  //   },
  //   {
  //     'image': 'assets/SummitKidaneMehret.jpg',
  //     'title': 'ሰሚት ኪዳነ ምህረት',
  //     'description':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
  //     'url':
  //         'https://www.google.com/maps/place/Summit+Kidane+Mihret+Church+%7C+%E1%88%B0%E1%88%9A%E1%89%B5+%E1%8A%AA%E1%8B%B3%E1%8A%90%E1%88%9D%E1%88%85%E1%88%A8%E1%89%B5+%E1%89%A4%E1%89%B0%E1%8A%AD%E1%88%AD%E1%88%B5%E1%89%B2%E1%8B%AB%E1%8A%95/@9.0081063,38.8570848,17.05z/data=!4m6!3m5!1s0x164b9a8a56841571:0x6f8fd9a821b8e00e!8m2!3d9.0062775!4d38.8601071!16s%2Fg%2F11by_y6p53?hl=en&entry=ttu',
  //     'more': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh '
  //   },
  //   {
  //     'image': 'assets/MeriFanuel.jpg',
  //     'title': 'መሪ ቅዱስ ፋኑኤል',
  //     'description': 'ደብረ ታቦር ቅዱስ ፋኑኤል ወአብርሐ ወአጽብሐ ቤተ ክርስቲያን',
  //     'url':
  //         'https://www.google.com/maps/place/Meri+Debre+Tabor+St.Fanuhel+%26+Abreha+weAtsebeha+Church/@9.0269866,38.8725764,17.05z/data=!4m6!3m5!1s0x164b908549e858b5:0x8572170e94fc42f3!8m2!3d9.0282673!4d38.8724996!16s%2Fg%2F11dft0hym8?hl=en&entry=ttu',
  //     'more': 'kajs ashdfjahdj ashd fjahsd jash dfas ajs djahsd aksdfh '
  //   },
  // ];
  // ደብሩ የተመሰረተው በ190 የደብሩ ሰንበተ ትምህርት ቤት፡ አንቀጽ ብርሃን ሰንበት ትምህርት ቤት
// List<bool> _isExpandedList = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize _isExpandedList with false values
//     _isExpandedList = List.generate(items.length, (index) => false);
//   }

//   Future<void> _launchURL(String url) async {
//     try{
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       print('Coluld not launch $url');
//       throw 'Could not launch $url';
//     }
//     }catch(e){
//       print('Error launching URL: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//             child: Text('AddisAbeba/LemiKura',
//                 style: TextStyle(fontWeight: FontWeight.bold))),
//         backgroundColor: Colors.grey.withOpacity(0.5),
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Opacity(
//             opacity: 0.3,
//             child: Image.asset(
//               'assets/Medhanealem.jpg',
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
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[850],
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: Colors.white, width: 2),
//                       ),
//                       child: Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                             ),
//                             child: Image.asset(
//                               items[index]['image']!,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: 200,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(13.0),
//                             child: Center(
//                               child: Text(
//                                 items[index]['title']!,
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(0, 255, 240, 1),
//                                     fontSize: 21,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     items[index]['description']!,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 GestureDetector(
//                                   onTap: () {
//                                     _launchURL(items[index]['url']!);
//                                   },
//                                   child: Text(
//                                     'Click Me',
//                                     style: TextStyle(
//                                       color: Colors.blue,
//                                       fontSize: 16,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       _isExpandedList[index] =
//                                           !_isExpandedList[index];
//                                     });
//                                   },
//                                   child: Text(
//                                     _isExpandedList[index]
//                                         ? 'Show Less'
//                                         : 'More Info',
//                                     style: TextStyle(
//                                       color: Colors.blue,
//                                       fontSize: 16,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ),
//                                 if (_isExpandedList[index]) ...[
//                                   SizedBox(height: 10),
//                                   Text(
//                                     items[index]['more']!,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
    
//       bottomNavigationBar:
//           BottomNavigationBar(items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//       ]),
//     );
//   }
// }


