import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class Carousel extends StatelessWidget {
  Carousel({super.key});
  List<String> d = [
    "https://cdn.pixabay.com/photo/2015/07/05/10/18/tree-832079_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/01/28/23/35/hills-615429_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_1280.jpg",
    "https://cdn.pixabay.com/photo/2012/08/06/00/53/bridge-53769_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/05/24/16/48/mountains-1412683_1280.png"
  ];
  List<Color> c = [
    Colors.black,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<DashboardProvider>(builder: (context, value, child) {
          // print(value.banner[0].sliderImages);
          return Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              color: Colors.white,
              child: CarouselSlider.builder(
                  itemCount: 4,
                  options: CarouselOptions(
                    // aspectRatio: 2,
                    height: height(context) * 0.25,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 10),
                    // autoPlayCurve: Curves.fastOutSlowIn,
                    // enlargeCenterPage: true,
                    // enlargeFactor: 2,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      context.read<DashboardProvider>().carouselDot(index);
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    // print("object");
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(value.sliderImages[index]),
                          fit: BoxFit.fill,
                        ),
                        // color: c[index],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    );
                  }));
        }),
        Consumer<DashboardProvider>(builder: (context, value, child) {
          // print(value.banner);
          return Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: value.sliderImages.asMap().entries.map((e) {
                return Container(
                  width: value.currentDot == e.key
                      // ? 2.w
                      ? width(context) * 0.04
                      // : 1.w,
                      : width(context) * 0.015,
                  // height: 1.w,
                  height: height(context) * 0.008,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: value.currentDot == e.key
                          ? Colors.green
                          : Colors.white),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}
