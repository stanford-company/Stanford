import 'package:flutter/material.dart';

import '../../../core/routes/routes.dart';
import '../../../data/store/model/supplies_model.dart';

class StoreCard extends StatelessWidget {
  final SuppliesModel suppliesModel;
  const StoreCard({super.key, required this.suppliesModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: suppliesModel,
        );
      },
      child: Container(
        color: Color(0xfff3f3f6),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  suppliesModel.images[0].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              suppliesModel.nameAr,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff113F4E),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2),
            Text(
              suppliesModel.price,
              style: TextStyle(
                color: Color(0xff1B8064),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
