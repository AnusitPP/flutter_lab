import 'package:sqflite/sqflite.dart'; // นำเข้า sqflite สำหรับการทำงานกับ SQLite
import 'package:path/path.dart'; // ใช้สำหรับจัดการเส้นทางของฐานข้อมูล
import 'todo.dart'; // นำเข้าโมเดล Todo

class DatabaseHelper {
  static final DatabaseHelper _instance =
      DatabaseHelper._internal(); // สร้างตัวแปรเพื่อให้ DatabaseHelper เป็น singleton
  factory DatabaseHelper() =>
      _instance; // ใช้ factory constructor เพื่อให้ได้ instance เดียวกันทุกครั้ง
  static Database? _database; // ตัวแปรเพื่อเก็บ instance ของฐานข้อมูล

  DatabaseHelper._internal(); // คอนสตรัคเตอร์ส่วนตัว

  // ฟังก์ชันนี้ใช้ในการเปิดการเชื่อมต่อกับฐานข้อมูล
  Future<Database> get database async {
    if (_database != null)
      return _database!; // ถ้ามีฐานข้อมูลอยู่แล้วก็คืนค่าฐานข้อมูล
    _database =
        await _initDatabase(); // ถ้ายังไม่มีฐานข้อมูล ให้เปิดฐานข้อมูลใหม่
    return _database!;
  }

  // ฟังก์ชันนี้ใช้ในการสร้างฐานข้อมูล SQLite
  Future<Database> _initDatabase() async {
    var path = await getDatabasesPath(); // ใช้เพื่อหาที่เก็บฐานข้อมูล
    return openDatabase(
      join(path, 'todo.db'), // ชื่อไฟล์ฐานข้อมูล
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            task TEXT, 
            isCompleted INTEGER
          )
        ''');

        // สร้างตาราง todos โดยมีฟิลด์ id, task, และ isCompleted
      },
      version: 1, // ระบุเวอร์ชันของฐานข้อมูล
    );
  }

  // ฟังก์ชันนี้ใช้ในการเพิ่ม Todo ใหม่ลงในฐานข้อมูล
  Future<int> insertTodo(Todo todo) async {
    final db = await database; // เปิดการเชื่อมต่อกับฐานข้อมูล
    return await db.insert(
      'todos',
      todo.toMap(),
    ); // เพิ่ม Todo ใหม่ลงในตาราง 'todos'
  }

  // ฟังก์ชันนี้ใช้ในการดึงข้อมูล Todo ทั้งหมดจากฐานข้อมูล
  Future<List<Todo>> getTodos() async {
    final db = await database; // เปิดการเชื่อมต่อกับฐานข้อมูล
    final List<Map<String, dynamic>> maps = await db.query(
      'todos',
    ); // ดึงข้อมูลจากตาราง 'todos'
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]); // แปลงข้อมูลจาก Map เป็น Todo object
    });
  }

  // ฟังก์ชันนี้ใช้ในการอัปเดตสถานะของ Todo
  Future<int> updateTodo(Todo todo) async {
    final db = await database; // เปิดการเชื่อมต่อกับฐานข้อมูล
    return await db.update(
      'todos', // ชื่อของตารางที่ต้องการอัปเดต
      todo.toMap(), // ข้อมูลที่ต้องการอัปเดต, แปลงเป็น Map
      where: 'id = ?', // เงื่อนไขที่ใช้ในการเลือกแถวที่จะอัปเดต
      whereArgs: [todo.id], // ค่าของ id ที่จะใช้ในการค้นหาแถว
    ); // อัปเดต Todo ที่มี id ตรงกับที่กำหนด
  }

  // ฟังก์ชันนี้ใช้ในการลบ Todo จากฐานข้อมูล
  Future<int> deleteTodo(int id) async {
    final db = await database; // เปิดการเชื่อมต่อกับฐานข้อมูล
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    ); // ลบ Todo ที่มี id ตรงกับที่กำหนด
  }
}
