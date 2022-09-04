import 'package:firebase_firestore_crud_app/models/product.dart';
import 'package:firebase_firestore_crud_app/screens/add_edit_product.dart';
import 'package:firebase_firestore_crud_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final products = Provider.of<List<Product>?>(context);

    return Scaffold(
      appBar: AppBar(
        // เอาลูกศรย้อนกลับซ้ายบนออก
        automaticallyImplyLeading: false,
        title: const Text('รายการสินค้า'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
            },
            icon: Icon(Icons.map)
          ),
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditProductScreen()));
            },
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: (products != null) ? ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name!),
            trailing: Text(products[index].price.toString()),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEditProductScreen(products[index])));
            },
          );
        }
      )
      : Center(child: CircularProgressIndicator(),),
    );
  }
}