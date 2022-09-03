class Product {

  final String? productId;
  final String? name;
  final double? price;
  final dynamic createdOn;

  Product({
    this.productId,
    this.name,
    this.price,
    this.createdOn,
  });


  // ส่งค่าจากฟอร์มไปหา Firestore
  // dynamic: คือเป็นอะไรก็ได้ เป็นเลข เป็นตัวอักษร เป็นวันที่ บลา ๆ
  Map<String, dynamic> toMap(){
    return {
      'productId' : productId,
      'name' : name,
      'price' : price,
      'createdOn': createdOn
    };
  }

  // อ่านค่าจาก Firestore มาเก็บ
  Product.fromFirestore(Map<String, dynamic> firestore) 
    : productId = firestore['productId'],
      name = firestore['name'],
      price = firestore['price'],
      createdOn = firestore['createdOn'];

}