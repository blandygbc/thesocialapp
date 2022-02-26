import 'package:flutter/material.dart';
import 'package:thesocialapp/core/services/cache_service.dart';
import 'package:thesocialapp/meta/views/authentication/login_view.dart';
import 'package:thesocialapp/meta/views/home_view/home_view.dart';
import 'package:thesocialapp/meta/views/splash_view/splash_view.dart';

class DeciderView extends StatelessWidget {
  static String routeName = "/decider";
  const DeciderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CacheService cacheService = CacheService();
    return FutureBuilder(
      future: cacheService.readCache(key: "jwt"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashView();
        }
        if (snapshot.hasData) {
          return const HomeView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
