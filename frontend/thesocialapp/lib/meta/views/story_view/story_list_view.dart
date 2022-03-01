import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/core/notifier/story_notifier.dart';

class StoryListView extends StatefulWidget {
  static String routeName = "/story-list";
  const StoryListView({Key? key}) : super(key: key);

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  @override
  Widget build(BuildContext context) {
    StoryNotifier storyNotifier(bool renderUi) => Provider.of<StoryNotifier>(
          context,
          listen: renderUi,
        );
    return Container(
      color: Colors.blue,
      height: 100,
      child: Row(children: [
        FutureBuilder(builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.deepPurpleAccent,
              ),
            );
          }
          return const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.person_off,
                color: Colors.white,
              ));
        })
      ]),
    );
  }
}
