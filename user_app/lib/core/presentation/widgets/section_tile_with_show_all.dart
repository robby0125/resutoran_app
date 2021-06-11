import 'package:flutter/material.dart';

class SectionTileWithShowAll extends StatelessWidget {
  final String title;
  final Function onTap;

  SectionTileWithShowAll({
    @required this.title,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: InkWell(
        onTap: onTap,
        child: Text(
          'Lihat Semua',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
