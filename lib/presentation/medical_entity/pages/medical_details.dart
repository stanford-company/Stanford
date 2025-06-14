import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medapp/presentation/medical_entity/pages/medical_details_images.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicalDetailsScreen extends StatelessWidget {
  const MedicalDetailsScreen({super.key});

  void _launchPhone() async {
    final Uri url = Uri.parse('tel:+962790000000');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng location = const LatLng(
      31.963158,
      35.930359,
    ); // Example for Amman

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MedicalDetailsImages(),

            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'عن الدكتور',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'الدكتور فهد هو طبيب مختص في الأنف والأذن والحنجرة يتمتع بخبرة كبيرة في تشخيص وعلاج مشكلات الأنف الواسعة في الحالات في الأردن...'
                    'يؤكد الدكتور فهد على أهمية التواصل مع المرضى لفهم احتياجاتهم الطبية وتوفير أفضل رعاية طبية ممكنة.',
                  ),
                  SizedBox(height: 16),
                  Text('الموقع', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    'عمان - حي الرضوان - مقابل حلويات جيبلة - الطابق الثالث',
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // Map
            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: location,
                  zoom: 14,
                ),
                markers: {
                  Marker(markerId: MarkerId('clinic'), position: location),
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // Book Now Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B8755),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Handle booking
          },
          child: const Text('احجز الآن', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
