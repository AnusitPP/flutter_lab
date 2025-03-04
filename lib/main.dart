import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String username = 'Anusit';
  String profileName = '';
  String position = '';
  String phone = '';

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      profileName = prefs.getString('profileName') ?? '';
      position = prefs.getString('position') ?? '';
      phone = prefs.getString('phone') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    print('Load Data Finish');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("Todo List"),
                ],
              ),
            ),
            ListTile(title: Text("Profile Page"), onTap: () {}),
            ListTile(title: Text("Todo List"), onTap: () {}),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            SizedBox(height: 10),
            if (profileName == "")
              Text(
                "ยังไม่ระบุชื่อ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            else
              Text(
                profileName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            Text(
              position == "" ? "ยังไม่ระบุตำแหน่ง" : position,
              style: TextStyle(
                color: Color.fromARGB(255, 80, 124, 245),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // 'Tel: $phone'
              phone == "" ? "ยังไม่ระบุเบอร์โทรศัพท์" : phone,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              child: const Text('Edit Profile'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyFunction()),
                );
              },
              child: const Text('My Function'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController profilenameController =
      TextEditingController(); //final = เปลี่ยนแปลงค่าได้แค่ครั้งเดียวเท่านั้น
  final TextEditingController positionController =
      TextEditingController(); //final = เปลี่ยนแปลงค่าได้แค่ครั้งเดียวเท่านั้น
  final TextEditingController phoneController =
      TextEditingController(); //final = เปลี่ยนแปลงค่าได้แค่ครั้งเดียวเท่านั้น

  void _saveData() async {
    //async = ทำไปได้เลยโดยไม่ต้องรอ
    final prefs =
        await SharedPreferences.getInstance(); //await = รอก่อนจนกว่าจะเสร็จ

    prefs.setString('profileName', profilenameController.text);
    prefs.setString('position', positionController.text);
    prefs.setString('phone', phoneController.text);

    print('Save !!!]');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error 404 !'), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile'), backgroundColor: Colors.blue),
      body: SafeArea(
        //minimum: const EdgeInsets.all(50), ปรับขอบทั้งหมด
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ), // all = ทุกทิศทาง
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: profilenameController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  hintText: 'Anusit Panpimsen',
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: positionController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  hintText: 'Student',
                  labelText: 'ตำแหน่ง',
                ),
              ),
              TextField(
                controller: phoneController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  hintText: '0855555555',
                  labelText: 'หมายเลขโทรศัพท์',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFunction extends StatefulWidget {
  const MyFunction({super.key});

  @override
  State<MyFunction> createState() => _MyFunctionState();
}

class _MyFunctionState extends State<MyFunction> {
  dynamic getDayName(int value) {
    switch (value) {
      case 1:
        return "วันจันทร์";
      case 2:
        return "วันอังคาร";
      case 3:
        return "วันพุธ";
      case 4:
        return "วันพฤหัสบดี";
      case 5:
        return "วันศุกร์";
      case 6:
        return "วันเสาร์";
      case 7:
        return "วันอาทิตย์";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แปลงเลขเป็นชื่อวัน'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter a number (1-7)',
                labelText: 'Number',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            Text(
              getDayName(int.tryParse("") ?? 1), //แสดงชื่อวันตามเลขที่กรอก
              style: TextStyle(
                color: Colors.grey,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
