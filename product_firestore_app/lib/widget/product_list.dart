import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:product_firestore_app/service/database.dart';
import 'package:product_firestore_app/widget/product_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Database.myInstancs;
    var myStream = db.getAllproductStream();
    
    
    return Container(
      color: const Color.fromARGB(255, 204, 245, 251),
      padding:  const EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: myStream,

        builder: (context,snapshot){
          if(snapshot.data!.isEmpty){
            return const Center(child:Column(children: [ SizedBox(height: 300,), Text('ยังไม่มีข้อมูลสินค้า'),Text('กรุณาคลิ๊ก + มุมบนขวาเพื่อเพิ่มสินค้า')],));
          
          }
          
          else if(snapshot.hasData){
            return ListView.separated(
              
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction){
                    
                    if(direction == DismissDirection.endToStart){
                       db.deleteProduct(Product: snapshot.data![index]);  
                       show(context);
                    }
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red,),
                  child: ProductItem(product: snapshot.data![index],),
                  
                
                );
              },
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color:  Color.fromARGB(255, 12, 1, 85),
                indent: 10,
                endIndent: 10,
              ),

            );
            }
         
          return const Center(child:CircularProgressIndicator(),);
        }
        
        ),
    );
  }
 
 void show(BuildContext context) =>  showDialog(context: context, builder: (context)=> 
 AlertDialog(
  content: Text('แจ้งเตือน \n\n ข้อมูลสินค้าถูกลบแล้ว'), 
 actions: [
  TextButton(
    style: TextButton.styleFrom(backgroundColor: Colors.green),
    onPressed: (){
    Navigator.of(context).pop();
    }, 
    child: Text('ตกลง',style: TextStyle(color: Colors.white),)
    )
    ]
    )
  
  
  

);


}