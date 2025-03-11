import 'package:flutter/material.dart';

class TodolistPage extends StatelessWidget{
  const TodolistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todolist"),
      ),
      body: Center(
        child: Text("Todolist Page"),
      ),
    );
  }

}