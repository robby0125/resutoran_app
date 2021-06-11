import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resutoran_app/core/presentation/widgets/review_item.dart';

class AllReviewScreen extends StatelessWidget {
  static const routeName = '/all_review';

  final AllReviewArgs args;

  AllReviewScreen({
    @required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ulasan ${args.restaurantName}',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.plus),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          Map<String, dynamic> _review = args.reviews[index];

          return ReviewItem(
            photoUrl: _review['photoUrl'],
            userName: _review['displayName'],
            userReview: _review['review'],
            rating: _review['rate'],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
        itemCount: args.reviews.length,
      ),
    );
  }
}

class AllReviewArgs {
  final String restaurantName;
  final List<Map<String, dynamic>> reviews;

  AllReviewArgs({
    @required this.restaurantName,
    @required this.reviews,
  });
}
