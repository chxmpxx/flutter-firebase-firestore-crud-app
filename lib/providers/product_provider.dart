import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_crud_app/models/product.dart';
import 'package:firebase_firestore_crud_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// ChangeNotifier: เป็นตัวที่คอยตรวจว่า ui มีการอัปเดตตรงไหนบ้าง
class ProductProvider with ChangeNotifier {

  // สร้าง Object FireService
  final firestoreService = FirestoreService();

  String? _name;
  double? _price;
  String? _productId;
  // FieldValue: ไว้อ่าน value ของฝั่ง Firebase
  // serverTimestamp: เวลาที่อยู่ทางฝั่งของ firebase
  FieldValue _createdOn = FieldValue.serverTimestamp();
  var uuid = Uuid();

  // Getters
  String? get name => _name;
  double? get price => _price;

  // Setters
  // พอ ui เปลี่ยนค่าก็ต้องเรียกมาที่ provider -> provider ก็ต้องมี setter ไว้อัปเดต value
  changeName(String value) {
    _name = value;
    // notifyListeners: ไว้อัปเดต value
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  // ดึงรายการสินค้า
  loadValues(Product product){
    _name = product.name;
    _price = product.price;
    _productId = product.productId;
  }

  // บันทึกและแก้ไขรายการสินค้า
  saveProduct() {
    if (_productId == null) {
      // uuid.v4 -> v.4 จะแรนด้อมแบบ string
      var newProduct = Product(name: name, price: price, productId: uuid.v4(), createdOn: _createdOn);
      firestoreService.saveProduct(newProduct);
    } else {
      //Update
      var updatedProduct = Product(name: name, price: _price, productId: _productId, createdOn: _createdOn);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  // การลบข้อมูลออกจาก firestore
  removeProduct(String productId){
    firestoreService.removeProduct(productId);
  }

}