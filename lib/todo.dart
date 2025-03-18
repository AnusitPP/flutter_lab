class Todo {
  int? id; // id เป็นตัวแปรที่ใช้เก็บหมายเลข ID ของ Todo
  String task; // task เก็บชื่อหรือรายละเอียดของ Todo
  bool isCompleted; // isCompleted เก็บสถานะว่า Todo เสร็จหรือยัง

  Todo({this.id, required this.task, required this.isCompleted});

  // ฟังก์ชันนี้ใช้ในการแปลงข้อมูล Todo ให้อยู่ในรูปแบบของ Map (json)
  Map<String, dynamic> toMap() {
    return {
      'id': id, // เก็บ id ของ Todo
      'task': task, // เก็บรายละเอียดของ Todo
      'isCompleted': isCompleted ? 1 : 0, // แปลง bool เป็น 1 หรือ 0
    };
  }

  // ฟังก์ชันนี้ใช้ในการแปลงข้อมูลจาก Map กลับมาเป็น Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'], // สร้าง Todo จากข้อมูลใน Map โดยใช้ 'id'
      task: map['task'], // ใช้ 'task' จาก Map
      isCompleted: map['isCompleted'] == 1, // ตรวจสอบว่า isCompleted เป็น 1 (เสร็จแล้ว) หรือไม่
    );
  }
}

