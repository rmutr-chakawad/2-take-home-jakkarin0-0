import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/widget/product_form.dart';

class ProductPopup extends StatelessWidget {
  ProductModel? product;
 ProductPopup({super.key,this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        //ให้ขึ้นด้านล่าง
        bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: const  BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            color: Colors.white
          ),

          height: MediaQuery.of(context).size.height * 0.4,
          child: ProductForm(),
        
        ),
    );

  }
}