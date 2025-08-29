import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperScreen extends StatefulWidget {
  const SwiperScreen({super.key});

  @override
  State<SwiperScreen> createState() => _SwiperScreenState();
}

class _SwiperScreenState extends State<SwiperScreen> {
  final List<Map<String, dynamic>> _promotions = [
    {
      'title': 'Special Offer',
      'description': '50% OFF on First Order',
      'backgroundColor': Colors.blue,
      'textColor': Colors.white,
    },
    {
      'title': 'Free Delivery',
      'description': 'On Orders Above \$30',
      'backgroundColor': Colors.orange,
      'textColor': Colors.white,
    },
    {
      'title': 'Weekend Special',
      'description': 'Get 20% Cashback',
      'backgroundColor': Colors.green,
      'textColor': Colors.white,
    },
    {
      'title': 'Happy Hours',
      'description': 'Buy 1 Get 1 Free',
      'backgroundColor': Colors.purple,
      'textColor': Colors.white,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size.height * 0.2,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: _promotions[index]['backgroundColor'],
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/400/200?random=${index + 1}',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _promotions[index]['title'],
                        style: TextStyle(
                          color: _promotions[index]['textColor'],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _promotions[index]['description'],
                        style: TextStyle(
                          color: _promotions[index]['textColor'],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: _promotions.length,
            pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.white,
                color: Colors.white54,
              ),
            ),
            autoplay: true,
            autoplayDelay: 5000,
            duration: 1000,
          ),
        ),
      ),
    );
  }
}
