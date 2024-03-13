import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/model/search_list.dart';

class CardSearchList extends StatelessWidget {
  final Restaurant list;

  const CardSearchList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: Image.network(
              "https://restaurant-api.dicoding.dev/images/medium/${list.pictureId}",
              width: 100,
              fit: BoxFit.fill,
              errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
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
          onTap: () {
            Navigator.pushNamed(context, DetailScreen.routeName,
                arguments: list.id);
            },
        )
    );
  }
}
