import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/core/notifier/story_notifier.dart';

class StoryAddView extends StatefulWidget {
  static String routeName = "/story-add";
  const StoryAddView({Key? key}) : super(key: key);

  @override
  State<StoryAddView> createState() => _StoryAddViewState();
}

class _StoryAddViewState extends State<StoryAddView> {
  StoryNotifier storyNotifier(bool renderUi) => Provider.of<StoryNotifier>(
        context,
        listen: renderUi,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (storyNotifier(true).selectedStoryAsset != null)
            Image.file(storyNotifier(true).selectedStoryAsset!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  storyNotifier(false).storyPickAssets();
                },
                child: Text((storyNotifier(true).selectedStoryAsset == null)
                    ? "Add Images"
                    : "Reselect"),
              ),
              if (storyNotifier(true).selectedStoryAsset != null)
                ElevatedButton(
                  onPressed: () {
                    storyNotifier(false).storyRemoveAssets();
                  },
                  child: const Text("Remove Image"),
                ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await storyNotifier(false).storyUploadAssets(context: context);
              await storyNotifier(false).storyAdd(
                  context: context,
                  story_assets: [
                    storyNotifier(false).uploadedImageurl!.toString()
                  ]);
              Navigator.pop(context);
            },
            child: const Text("Upload Story"),
          ),
        ],
      )),
    );
  }
}
