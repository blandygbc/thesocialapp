import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/app/routes/routes.dart';
import 'package:thesocialapp/app/providers/provider.dart';
import 'package:thesocialapp/meta/views/decider_view/decider_view.dart';

void main() {
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const Lava(),
    );
  }
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Social App',
      theme: ThemeData.dark(),
      initialRoute: DeciderView.routeName,
      routes: routes,
    );
  }
}
