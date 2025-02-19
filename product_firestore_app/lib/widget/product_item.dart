import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/widget/product_form.dart';
import 'package:product_firestore_app/widget/product_popup.dart';

class ProductItem extends StatelessWidget {
  ProductModel product;
  ProductItem({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          isScrollControlled: true,
          context: context, 
          builder: (context){
            return ProductPopup(product: product);
          } 
        );

      },
      child: ListTile(
        
        leading: Text(product.productName,style: const TextStyle(fontSize: 20),),
        title: Text('ราคา ${product.price.toStringAsFixed(2)} บาท',textAlign: TextAlign.right,),
        trailing: IconButton(onPressed: (){
          showBottomSheet(context: context, builder: (context)=> ProductForm(product: product,));
        }, icon: const Icon(Icons.chevron_right),)
        
        

      ),

    
    );
  }
}