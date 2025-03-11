import 'drawer.dart';
import 'package:flutter/material.dart';

class TodolistPage extends StatefulWidget{
  const TodolistPage({super.key});

  @override
  State<TodolistPage> createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todolist"),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        children: [
          ListTile(
            title: Text("ตื่นนอนแบบไม่สาย"),
            trailing: Checkbox(value: false, onChanged: (value){}),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },child: Icon(Icons.more_horiz_rounded,)
        ),
    );
  }
}