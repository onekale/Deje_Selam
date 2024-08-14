import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.church,
                  color: Colors.black38,
                  size: 30,
                ),
              ),

              const SizedBox(height: 25),

              // home title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.home, color: Colors.black38, size: 30),
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(26, 46, 73, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    //navigate to home page
                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
              ),

              // Profile title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.share, color: Colors.black38, size: 30),
                  title: const Text("S H A R E",
                      style: TextStyle(fontSize: 13, color: Colors.green)),
                  onTap: () {
                    //pop drawer
                    // Navigator.pop(context);
                    //navigate to profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              //Users title

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.developer_board,
                      color: Colors.black38, size: 30),
                  title: const Text("A P P",
                      style: TextStyle(fontSize: 13, color: Colors.green)),
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    //navigate to users page
                    Navigator.pushNamed(context, '/aboutApp');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading:
                      Icon(Icons.person_2, color: Colors.black38, size: 30),
                  title: const Text("D E V E L O P E R",
                      style: TextStyle(
                          fontSize: 13, color: Color.fromRGBO(26, 46, 73, 1))),
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    //navigate to users page
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
