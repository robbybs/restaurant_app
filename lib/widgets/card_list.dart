import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/navigation.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/model/restaurant_list.dart';

import '../provider/database_provider.dart';

class CardList extends StatelessWidget {
  final Restaurant list;

  const CardList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorite(list.id),
        builder: (context, snapshot) {
          var isFavorite = snapshot.data ?? false;
          return Material(
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
                      const Center(child: Icon(Icons.error)),
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
                            color: Colors.black, fontStyle: FontStyle.italic),
                        text: list.description),
                  ),
                  onTap: () => Navigation.intentWithData(DetailScreen.routeName, list.id),
                  trailing: isFavorite
                      ? IconButton(
                          onPressed: () => provider.removeFavorite(list.id),
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                        )
                      : IconButton(
                          onPressed: () => provider.addFavorite(list),
                          icon: const Icon(Icons.favorite_border))));
        },
      );
    });
  }
}
