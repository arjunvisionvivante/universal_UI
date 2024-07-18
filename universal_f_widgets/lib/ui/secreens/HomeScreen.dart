import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

import '../widgets/EndDrawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: EndDrawer(),
      appBar: AppBar(
        title: Text('Brand Logo'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {},
        //   ),
        //
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            HeroSection(),
            // Product Categories
            ProductCategories(),
            // Featured Products
            FeaturedProducts(),
            // Banners and Promotions
            Promotions(),
            // Testimonials
            Testimonials(),
            // Footer
            Footer(),
          ],
        ),
      ),
    );
  }
}

// Placeholder widgets for each section
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider('https://www.pexels.com/search/onlinestore/'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Shop Now'),
        ),
      ),
    );
  }
}

class ProductCategories extends StatelessWidget {
  final List<String> categories = [
    'Electronics',
    'Fashion',
    'Home & Kitchen',
    'Beauty',
    'Toys',
    'Sports',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: 10.0),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Card(
                child: Center(
                  child: Text(categories[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FeaturedProducts extends StatelessWidget {
  final List<String> featuredImages = [
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Featured Products', style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: 10.0),
          Container(
            height: 200.0,
            child: Swiper(
              itemCount: featuredImages.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: featuredImages[index],
                  fit: BoxFit.cover,
                );
              },
              pagination: SwiperPagination(),
              control: SwiperControl(),
            ),
          ),
        ],
      ),
    );
  }
}

class Promotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Promotions', style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: 10.0),
          Card(
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider('https://via.placeholder.com/800x400'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Testimonials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Testimonials', style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: 10.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Great product! Highly recommend.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('- John Doe'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Us'),
          Text('Contact'),
          Text('Privacy Policy'),
          Text('Terms of Service'),
        ],
      ),
    );
  }
}
