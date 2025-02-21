import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_firestore_app/models/product_model.dart';

class Database {
  static Database myInstancs =  Database();
  
  //ส่งข้อมูล มายังไคแอน
  Stream<List<ProductModel>> getAllproductStream(){
    //กำหนดชื่อ เพื่อเรียกใช้ตารางนั้น
    var reference = FirebaseFirestore.instance.collection('product');
    //query ในแบบno sql
    Query query = reference.orderBy('id', descending: true); 
    var querySnapshot = query.snapshots(); //ดึงข้อมูลแล้วส่งมาเก็ยไว้ที่ querysnapshot  
    
    return querySnapshot.map(
      
      (snapshots){
        return snapshots.docs.map(
          
          (doc){
            return ProductModel.formMap(doc.data() as Map<String,dynamic>);

          }).toList(); //return แบบ list 
      }
    );


  }
//การเพิ่มข้อมูล เข้า DB
  Future<void> setProduct({required ProductModel product})async{
    var reference = FirebaseFirestore.instance.doc('product/${product.id}');
    try { 
      await reference.set(product.toMap());
    }catch (e){
      rethrow;
    }
  }

//การลบข้อมูล
  Future<void> deleteProduct({required ProductModel Product})async{
    var reference = FirebaseFirestore.instance.doc('product/${Product.id}');
    try { 
      await reference.delete();
    }catch (e){
      rethrow;
    }
  }

}