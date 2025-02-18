import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/service/database.dart';

class ProductForm extends StatefulWidget {
  //เรียกใช้ เพื่อให้ข้อมูลไปเก็บในตัวแปร ที่สร้างใน model
  ProductModel? product;
  ProductForm({super.key,this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  //ส่งค่าเข้า DB
  Database db = Database.myInstancs;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  
 //ทำเใื่อตอนเรียกใช้งานครั้งแรก ทำครั้งเดียว
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.product != null){
      nameController.text = widget.product!.productName;
      priceController.text = widget.product!.price.toString();
    }
  }
 //ทำเมื่อตอนเรียกใช้งานครั้งสุดท้าย ทำครั้งเดียว
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
    child: 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        IconButton(onPressed: (){  Navigator.of(context).pop();}, icon: Icon( Icons.keyboard_arrow_down_outlined ),iconSize: 30,color: Colors.deepPurple,),
        const SizedBox(height: 10,),
        Text(widget.product == null?  'เพิ่มสินค้า': 'แก้ไข ${widget.product!.productName}'),
        TextField(
          controller: nameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'ชื่อสินค้า'),
          
        ),

        TextField(
          controller: priceController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'ราคาสินค้า'),
          
        ),

        const SizedBox(height: 15,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showBtnOk(context),
            SizedBox(width: 20,),
            showBtnCancle(context),
          ],)

      ],
    
    
    ));
  }

  Widget showBtnOk(BuildContext context){
    return ElevatedButton(
        
      //การส่งข้อมูลเข้า DB
        onPressed: ()async{
        
        String newId = 'PD${DateTime.now().millisecondsSinceEpoch.toString()}';
        await db.setProduct(
          product: ProductModel(
            id: widget.product == null? newId : widget.product!.id,
            productName: nameController.text, 
            price: double.tryParse(priceController.text) ?? 0
          ) 
        );
        nameController.clear();
        priceController.clear();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }, 
      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 4, 71, 6)),
      child: const Text('เพิ่ม',style: TextStyle(color: Colors.white),));
  }

  Widget showBtnCancle(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        
        Navigator.of(context).pop();
      }, 
      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 71, 15, 4)),
      child: const Text('ปิด',style: TextStyle(color: Colors.white),));
  }
}