import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:thesocialapp/core/notifier/authentication_notifier.dart';
import 'package:thesocialapp/core/services/cache_service.dart';
import 'package:thesocialapp/meta/views/add_post/add_post_view.dart';
import 'package:thesocialapp/meta/views/authentication/login_view.dart';

class HomeView extends StatelessWidget {
  static String routeName = "/home";
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CacheService cacheService = CacheService();
/*     final authenticationNotifier = Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    ) */
    return Scaffold(
      appBar: AppBar(title: const Text("Home View")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).pushNamed(AddPostView.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                cacheService.deleteCache(key: "jwt").whenComplete(() {
                  Navigator.of(context).pushNamed(LoginView.routeName);
                });
              },
              child: const Text("Logout"))),
    );
  }
}
