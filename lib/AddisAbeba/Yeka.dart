import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Yeka extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/Medhanealem.jpg',
      'title': 'ቦሌ መድኃኒዓለም',
      'description': 'ደብረ ሳሌም መድኃኒዓለም ቤተ ክርስቲያን',
      'url':
          'https://www.google.com/maps/place/Sealite+Mihret+Church/@9.0194616,38.8274434,16.95z/data=!4m6!3m5!1s0x164b9ab1469251e9:0x3a5e2387af070799!8m2!3d9.0189796!4d38.8285844!16s%2Fg%2F11hbvplxl5?entry=ttu'
    }
    // Add more items as needed
  ];

  Future<void> _launchURL(String url) async {
    // Ensure the URL can be launched
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Color.fromRGBO(0, 255, 240, 1), width: 2),
              ),
              child: Column(
                children: [
                  // Image at the top
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      items[index]['image']!, // Path to the image
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200, // Adjust the height as needed
                    ),
                  ),
                  // Text title
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Center(
                      child: Text(
                        items[index]['title']!, // Description text
                        style: TextStyle(
                            color: Color.fromRGBO(0, 255, 240, 1),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Text description at the bottom
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      items[index]['description']!, // Description text
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
