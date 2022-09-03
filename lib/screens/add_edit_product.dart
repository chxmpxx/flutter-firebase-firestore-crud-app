import 'package:firebase_firestore_crud_app/models/product.dart';
import 'package:firebase_firestore_crud_app/providers/product_provider.dart';
import 'package:firebase_firestore_crud_app/screens/product_screen.dart';
import 'package:firebase_firestore_crud_app/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditProductScreen extends StatefulWidget {

  // Load model มาสร้างเป็น Object
  Product? product;

  AddEditProductScreen([this.product]);

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  // dispose: เป็นการเคลียร์ค่าออก
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // เพิ่มรายการสินค้าใหม่
    if(widget.product == null) {
      nameController.text = "";
      priceController.text = "";
      // Duration.zero: ไม่ดีเลย์
      Future.delayed(Duration.zero, (){
        // listen: true = รีโหลดหน้า ถ้าเป็น false จะทำแค่โยนค่าไป provider และจะไม่รีโหลดหน้านี้ใหม่
        final productProvider = Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(Product());
      });
    }
    // อัปเดตรายการสินค้า
    else {
      nameController.text = widget.product!.name!;
      priceController.text = widget.product!.price!.toString();
      Future.delayed(Duration.zero, (){
        // listen: true = รีโหลดหน้า ถ้าเป็น false จะทำแค่โยนค่าไป provider และจะไม่รีโหลดหน้านี้ใหม่
        final productProvider = Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(widget.product!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider?>(context);

    return Scaffold(
      appBar: AppBar(
        title: (widget.product != null) ? Text('แก้ไขข้อมูลสินค้า') : Text('เพิ่มสินค้าใหม่'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'ชื่อสินค้า'),
              onChanged: (value) {
                productProvider!.changeName(value);
              },
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'ราคา'),
              onChanged: (value) => productProvider!.changePrice(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('บันทึกรายการ'),
              onPressed: () {
                if (nameController.text != "" && priceController.text != "") {
                  productProvider!.saveProduct();
                  // ส่งกลับไปหน้า product
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductScreen()));
                } else {
                  BottomSheetWidget().bottomSheet(context, "มีข้อผิดพลาด", "ป้อนข้อมูลให้ครบก่อน");
                }
              },
            ),
            (widget.product != null) ? RaisedButton(
              color: Colors.red[300],
              child: Text('ลบข้อมูลสินค้านี้', style: TextStyle(color: Colors.white),),
              onPressed: () {
                // set up the buttons
                Widget remindButton = FlatButton(
                  child: Text("ยืนยันลบข้อมูล"),
                  onPressed: () {
                    productProvider!.removeProduct(widget.product!.productId!);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProductScreen()));
                  },
                );
                Widget cancelButton = FlatButton(
                  child: Text("ปิดหน้าต่าง"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("ยืนยันการลบข้อมูล"),
                  content: Text(
                      "หากต้องการลบข้อมูลนี้ กรุณาคลิ๊กยืนยันการลบข้อมูล"),
                  actions: [
                    remindButton,
                    cancelButton,
                  ],
                );
                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
            )
            : Container()
          ],
        ),
      ),
    );
  }
}