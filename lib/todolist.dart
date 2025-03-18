import 'package:firstapp/database_helper.dart';
import 'package:firstapp/todo.dart';
import 'drawer.dart';
import 'package:flutter/material.dart';

class TodolistPage extends StatefulWidget {
  const TodolistPage({super.key});

  @override
  State<TodolistPage> createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  late Future<List<Todo>> _todoList;

  @override
  void initState() {
    super.initState();
    _todoList = _fetchTodos(); // ดึงข้อมูล Todo เมื่อเริ่มต้นหน้า
  }

  Future<List<Todo>> _fetchTodos() async {
    return await DatabaseHelper().getTodos();
  }

  void _addTodo() {
    TextEditingController _todoController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        String task = '';
        return AlertDialog(
          title: Text("Add Todo"),
          content: TextField(
            onChanged: (value) {
              task = value;
            },
            controller: _todoController,
            decoration: InputDecoration(hintText: 'Enter Todo'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (task.isNotEmpty) {
                  final todo = Todo(task: task, isCompleted: false);
                  DatabaseHelper().insertTodo(todo);
                  setState(() {
                    _todoList = _fetchTodos();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("บันทึก"),
            ),
          ],
        );
      },
    );
  }

  void _toggleTodoCompletion(Todo todo) async {
    todo.isCompleted = !todo.isCompleted; // สลับสถานะการทำเสร็จ
    await DatabaseHelper().updateTodo(todo); // อัปเดตสถานะในฐานข้อมูล
    setState(() {
      _todoList = _fetchTodos(); // รีเฟรชรายการ Todo หลังจากอัปเดต
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todolist")),
      drawer: CustomDrawer(),
      body: FutureBuilder<List<Todo>>(
        future: _todoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            ); // แสดง loading ถ้ายังโหลดไม่เสร็จ
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            ); // แสดงข้อความถ้ามีข้อผิดพลาด
          }
          final todos =
              snapshot.data ??
              []; // ถ้าไม่มีข้อมูลให้ใช้ค่าเริ่มต้นเป็นลิสต์ว่าง
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.task),
                trailing: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    _toggleTodoCompletion(todo);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
