import 'package:firstapp/main.dart';
import 'package:firstapp/todolist.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  "Todo List",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Profile Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage()),
              );
            },
          ),
          ListTile(
            title: Text("Todo List"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodolistPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
