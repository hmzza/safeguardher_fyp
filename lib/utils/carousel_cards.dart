import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselCards extends StatelessWidget {
  final List<String> imgList = [
    'assets/images/a.png',
    'assets/images/b.png',
    'assets/images/c.png',
    'assets/images/d.png',
    'assets/images/e.png',
    // ... add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeCenterPage: true,
        viewportFraction: 0.8, // Adjust viewport fraction to less than 1
        aspectRatio: 1.5,
        padEnds: true, // This should be set in order to have the space at the ends
      ),
      items: imgList.map((item) => ClipRRect(
        borderRadius: BorderRadius.circular(15.0), // Adjust the border radius here
        child: Center(
          child: Image.asset(
            item,
            fit: BoxFit.cover,
            width: 1000,
            height: 1000,
          ),
        ),
      )).toList(),
    );
  }
}
