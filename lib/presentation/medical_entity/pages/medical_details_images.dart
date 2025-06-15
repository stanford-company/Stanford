import 'package:flutter/material.dart';

class MedicalDetailsImages extends StatefulWidget {
  const MedicalDetailsImages({super.key});

  @override
  State<MedicalDetailsImages> createState() => _MedicalDetailsImagesState();
}

class _MedicalDetailsImagesState extends State<MedicalDetailsImages> {
  final int _itemCount = 4;
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    // When reaching the last pages, jump to the first
    if (index == _itemCount - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _controller.jumpToPage(0);
      });
    }
  }

  final PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: _itemCount,
            onPageChanged: (index) => _onPageChanged(index),
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.asset(
                  'assets/images/doctor_profile.jpg', // Replace with your image
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        // Doctor image background

        // Back button
        Positioned(
          top: 40,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),

        // Indicator Dots
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDot(isActive: _currentPage == 0),
                  const SizedBox(width: 6),
                  _buildDot(isActive: _currentPage == 1),
                  const SizedBox(width: 6),
                  _buildDot(isActive: _currentPage == 2),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.green[400] : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
