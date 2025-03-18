import 'package:firstapp/database_helper.dart';
import 'package:firstapp/todo.dart';

import 'drawer.dart';
import 'package:flutter/material.dart';

class TodolistPage extends StatefulWidget{
  const TodolistPage({super.key});

  @override
  State<TodolistPage> createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  late Future<List<Todo>> _todolist;
  Future<List<Todo>> _fetchTodos() async {
    return await DatabaseHelper().getTodos();
  }
  void _addTodo(){
    TextEditingController _todoController = TextEditingController();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Add Todo"),
        content: TextField(
          controller: _todoController,
          decoration: InputDecoration(hintText: 'Enter Todo'),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, child: const Text("บันทึก"),
            ),
        ],
      );
    });
  }
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
          _addTodo();
        },child: Icon(Icons.add)
        ),
    );
  }
}