// core/widgets/health_tips_carousel.dart
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HealthTipsCarousel extends StatefulWidget {
  const HealthTipsCarousel({super.key});

  @override
  State<HealthTipsCarousel> createState() => _HealthTipsCarouselState();
}

class _HealthTipsCarouselState extends State<HealthTipsCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> _healthTips = [
    'Stay hydrated! Drink at least 8 glasses of water daily.',
    'Get 7-9 hours of sleep for optimal health.',
    'Take a 5-minute break every hour if you sit for long periods.',
    'Wash your hands frequently to prevent illness.',
    'Aim for 30 minutes of moderate exercise daily.',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: PageView.builder(
            controller: _controller,
            itemCount: _healthTips.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Center(
                    child: Text(
                      _healthTips[index],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _controller,
          count: _healthTips.length,
          effect: WormEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}