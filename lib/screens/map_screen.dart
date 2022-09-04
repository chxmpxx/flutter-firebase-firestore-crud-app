import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  // Object Google Map Controller
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // ใส่พิกัด latitude, longitude
  LatLng latLng = LatLng(13.8475694, 100.5696188);

  // ปักหมุด
  Map<MarkerId, Marker> markers = <MarkerId, Marker> {
    MarkerId('สาขาหลัก'):Marker(
      markerId: MarkerId('สาขาหลัก'),
      position: LatLng(13.8475694, 100.5696188),
      // pop-up เมื่อผู้ใช้คลิก
      infoWindow: InfoWindow(title: 'เกษตรศาสตร์บางเขน', snippet: '50 ถนน งามวงศ์วาน แขวง ลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900'),
      onTap: () {
        print('Marker Tapped');
      },
      // ลาก marker
      onDragEnd: (LatLng position) {
        print('Drag End');
      }
    ),
    MarkerId('สาขาย่อย'):Marker(
      markerId: MarkerId('สาขาย่อย'),
      position: LatLng(13.8476215, 100.5668615),
      // pop-up เมื่อผู้ใช้คลิก
      infoWindow: InfoWindow(title: 'บาร์ใหม่', snippet: '50 ซอย ชูชาติกำภู แขวง ลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900'),
      onTap: () {
        print('Marker Tapped');
      },
      // ลาก marker
      onDragEnd: (LatLng position) {
        print('Drag End');
      }
    )
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('พื้นที่ให้บริการของเรา'),
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        // initialCameraPosition: เวลาโหลดแผนที่ขึ้นมา ต้องการให้มุมกล้องอยู่พิกัดไหน, zoom กี่เท่า
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 17
        ),
        // มุมมอง map
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}