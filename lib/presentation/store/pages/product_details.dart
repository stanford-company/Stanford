import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/core/constants/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  int selectedImageIndex = 0;

  final List<String> productImages = [
    'assets/images/Rectangle 4.png',
    'assets/images/Rectangle 4.png',
    'assets/images/Rectangle 4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Main Product Image
            AspectRatio(
              aspectRatio: 1.2,
              child: Image.asset(
                productImages[selectedImageIndex],
                fit: BoxFit.cover,
              ),
            ),

            // Thumbnails
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(productImages.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedImageIndex = index);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedImageIndex == index
                                ? Colors.green
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(productImages[index], width: 50),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Availability
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Color(0xff80D5B5),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.green,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Currently Available',
                            style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '100 JOD',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Product Name
                  Row(
                    children: [
                      Text(
                        'كرسي طبي متحرك',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        icon: CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xff13434A),
                          child: Icon(Icons.remove),
                        ),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => quantity++);
                        },
                        icon: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.green,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Quantity Selector
                  Divider(),
                  const SizedBox(height: 12),

                  // Product Details
                  Text(
                    'تفاصيل المنتج',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'كرسي طبي متحرك مصمم لتوفير الراحة والدعم للمرضى الذين يحتاجون إلى مساعدة في التنقل. يتميز بإطار قوي وعجلات سهلة الحركة، مما يسهل على المستخدمين التنقل في مختلف البيئات.',
                    style: TextStyle(
                      color: Color(0xff6A717E),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Order Button
                  Container(
                    width: 360.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF29A07B), Color(0xFF1B8064)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border.all(color: Color(0xFF156752), width: 1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          // outer shadow
                          color: Color(0x80156752), // #15675280
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                        BoxShadow(
                          // inner inset shadow
                          color: Color(0x66FFFFFF), // #FFFFFF40
                          offset: Offset(0, 2),
                          blurRadius: 0,
                          spreadRadius: 1,
                          // requires flutter_inset_box_shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 32,
                      ),
                      child: Center(
                        child: Text(
                          'اطلب الآن',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
