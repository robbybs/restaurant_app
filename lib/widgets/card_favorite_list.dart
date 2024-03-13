import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/restaurant_list.dart';
import '../provider/database_provider.dart';
import '../screen/detail_screen.dart';

class CardFavoriteList extends StatelessWidget {
  final Restaurant list;

  const CardFavoriteList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorite(list.id),
        builder: (context, snapshot) {
          return Dismissible(
              key: Key(list.id),
              child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/${list.pictureId}",
                        width: 100,
                        fit: BoxFit.fill,
                        errorBuilder: (ctx, error, _) =>
                        const SizedBox(width: 100, child: Center(child: Icon(Icons.error)))
                    )
                  ),
                  title: Text(
                    list.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic),
                        text: list.description),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, DetailScreen.routeName,
                        arguments: list.id);
                  },),
              onDismissed: (direction) {
                provider.removeFavorite(list.id);
              });
        },
      );
    });
  }
}
