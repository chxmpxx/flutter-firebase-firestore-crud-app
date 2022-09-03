import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_firestore_crud_app/models/product.dart';
import 'package:firebase_firestore_crud_app/providers/product_provider.dart';
import 'package:firebase_firestore_crud_app/screens/product_screen.dart';
import 'package:firebase_firestore_crud_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{

  // ให้รองรับการอ่าน path https
  WidgetsFlutterBinding.ensureInitialized();

  // initial firebase
  await Firebase.initializeApp();

  final fireStoreService = FirestoreService();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final fireStoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider(create: (context) => fireStoreService.getProducts(), initialData: null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firestore CRUD',
        theme: ThemeData(
          primarySwatch: Colors.purple
        ),
        home: ProductScreen(),
      ),
    );
  }
}

