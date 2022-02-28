import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/core/model/post_model.dart';
import 'package:thesocialapp/core/notifier/post_notifier.dart';
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
    PostNotifier postNotifier(bool renderUi) => Provider.of<PostNotifier>(
          context,
          listen: renderUi,
        );
    return Scaffold(
      appBar: AppBar(title: const Text("Home View"), actions: [
        IconButton(
            onPressed: () => postNotifier(false).fetchPosts(context: context),
            icon: const Icon(Icons.refresh)),
        IconButton(
            onPressed: () {
              cacheService.deleteCache(key: "jwt").whenComplete(() {
                Navigator.of(context).pushNamed(LoginView.routeName);
              });
            },
            icon: const Icon(Icons.logout)),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).pushNamed(AddPostView.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder(
          future: postNotifier(false).fetchPosts(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final List _snapshot = snapshot.data as List;
              return ListOfPosts(snapshot: _snapshot);
            }
          },
        ),
      )),
    );
  }
}

class ListOfPosts extends StatelessWidget {
  final List snapshot;
  const ListOfPosts({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        PostData postData = snapshot[index];
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(postData.post_images[0]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(postData.post_user.userimage),
                  ),
                  title: Text(postData.post_title),
                  subtitle: Text(postData.post_text),
                  dense: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
