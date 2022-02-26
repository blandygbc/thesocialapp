import 'package:flutter/material.dart';
import 'package:thesocialapp/core/api/services/cache_service.dart';
import 'package:thesocialapp/meta/views/authentication/login_view.dart';

class HomeView extends StatelessWidget {
  static String routeName = "/home";
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CacheService cacheService = CacheService();
    return Scaffold(
      appBar: AppBar(title: const Text("Home View")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cacheService.deleteCache(key: "jwt").whenComplete(() {
            Navigator.of(context).pushNamed(LoginView.routeName);
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
