import 'package:flutter/material.dart';
import 'package:lab_1/models/clothes.dart';
import 'package:lab_1/screens.dart/details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Clothes> clothes = [
    Clothes(
      name: 'Clarice Womens Long Green Wool Coat',
      url:
          'https://www.angeljackets.com/ca/product_images/z/377/womens-green-long-wool-coat__96944_zoom.webp',
      description:
          'Premium Quality Wool Blend, Polyester inner lining, Semi-fitted silhouette.',
      price: 296,
    ),
    Clothes(
      name: 'Old Money Wide Pants',
      url:
          'https://mauv-studio.com/cdn/shop/files/Old-Money-Wide-Pants-MAUV-STUDIO-STREETWEAR-Y2K-CLOTHING_grande.jpg?v=1715741647',
      description:
          'Timeless style of old money sophistication, Provide both comfort and fashion',
      price: 53,
    ),
    Clothes(
      name: 'Sleeveless sweater with contrasting v-neck',
      url:
          'https://shopbloomingdaily.com/cdn/shop/files/womens-old-money-cable-knit-sweater-vest-top-cream-white-womens-shirts-tops-586001_1200x.jpg?v=1723390870',
      description:
          'Sleeveless sweater that stands out for its out-of-the-box elegance, Contrasting v-neck',
      price: 64,
    ),
    Clothes(
        name: 'Christie Jacket',
        url:
            'https://i0.wp.com/farahfsalem.com/wp-content/uploads/2023/11/old-money-winter-outfit-2.png?resize=900%2C1200&ssl=1',
        description:
            'Double-reast suit jacket, Two flap pockets in front, Slit in the lower back',
        price: 175),
    Clothes(
      name: 'Elegant dress',
      url:
          'https://d1fufvy4xao6k9.cloudfront.net/images/blog/posts/2023/12/hockerty_woman_wearing_a_dress_in_savile_row_5d0d2c32_c714_4028_bb5e_3c9320243d9a.jpg',
      description:
          'Made of high-quality fabrics that offer elegance and comfort even on the hottest days, Designed for all-day wear',
      price: 100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('191503'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: GridView.builder(
          itemCount: clothes.length,
          itemBuilder: (BuildContext context, int index) {
            final item = clothes[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(clothes: item),
                  ),
                );
              },
              child: Card.filled(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.network(
                          item.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.8),
        ),
      ),
    );
  }
}
