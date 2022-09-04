import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_crud_app/models/product.dart';

class FirestoreService {

  // สร้าง Object เพื่อเข้าถึง FirebaseFirestore
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // ฟังก์ชันบันทึก/แก้ไขข้อมูลลง FirebaseFirestore
  // ถ้าไม่เจอ collection ที่ Firestore จะสร้างใหม่เลย
  Future<void> saveProduct(Product product){
    return _db.collection('products').doc(product.productId).set(product.toMap());
  }

  // ฟังก์ชันอ่านข้อมูล
  // Stream คล้าย Future เป็น asynchronous เหมือนกัน
  Stream<List<Product>> getProducts(){
    // descending:true = เรียงจากราคามากสุดไปน้อยสุด
    return _db.collection('products').orderBy('price', descending: true)
              .snapshots().map((snapshot) => snapshot.docs.map((document) => Product.fromFirestore(document.data())).toList());
  }

  // ฟังก์ชันลบข้อมูล
  Future<void> removeProduct(String productId){
    return _db.collection('products').doc(productId).delete();
  }

}