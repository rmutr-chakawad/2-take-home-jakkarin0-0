import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_firestore_app/widget/home_page.dart';



// ต้อง async await ด้วย จากนั้น พิมพ์ตามดังกล่าวเพื่อกำหนดค่าเริ่มต้น แล้ว ประกาศแบบFuture 
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
