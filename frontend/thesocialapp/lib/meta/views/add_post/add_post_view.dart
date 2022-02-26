import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/app_constants.dart';
import 'package:thesocialapp/core/notifier/post_notifier.dart';
import 'package:thesocialapp/meta/views/home_view/home_view.dart';

class AddPostView extends StatefulWidget {
  static String routeName = "/add-post";
  const AddPostView({Key? key}) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postNotifier = Provider.of<PostNotifier>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Enter a title..."),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(hintText: "Enter a description..."),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (() {}), child: const Text("Select image")),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: (() async {
                    final response = await postNotifier.addPost(
                      context: context,
                      post_title: titleController.text,
                      post_text: descriptionController.text,
                    );
                    if (response.statusCode == statusCodeCreated) {
                      Navigator.of(context).pushNamed(HomeView.routeName);
                    } else {
                      final Map<String, dynamic> parsedValue =
                          json.decode(response.body);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        parsedValue['message'],
                      )));
                    }
                  }),
                  child: const Text("Post")),
            ],
          )),
        ),
      ),
    );
  }
}
