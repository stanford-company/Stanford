import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalDetailsImages extends StatefulWidget {
  final List<String> images;
  const MedicalDetailsImages({super.key, required this.images});

  @override
  State<MedicalDetailsImages> createState() => _MedicalDetailsImagesState();
}

class _MedicalDetailsImagesState extends State<MedicalDetailsImages> {
  // final int _itemCount = widget.images.length;
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    // When reaching the last page, jump to the first
    if (index == widget.images.length - 1) {
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
          height: 200.h,
          child: PageView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            onPageChanged: (index) => _onPageChanged(index),
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.network(
                  widget.images[index], // Replace with your image
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
                children: List.generate(
                  widget.images.length, // includes dots and spacing
                  (index) {
                    if (index.isEven) {
                      final pageIndex = index ~/ 2;
                      return _buildDot(isActive: _currentPage == pageIndex);
                    } else {
                      return const SizedBox(width: 6);
                    }
                  },
                ),
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
