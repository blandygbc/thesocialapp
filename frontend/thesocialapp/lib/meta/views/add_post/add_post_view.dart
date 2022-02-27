import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/app_constants.dart';
import 'package:thesocialapp/core/dto/post_dto.dart';
import 'package:thesocialapp/core/notifier/authentication_notifier.dart';
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
    PostNotifier postNotifier(bool renderUi) => Provider.of<PostNotifier>(
          context,
          listen: renderUi,
        );
    final authenticationNotifier = Provider.of<AuthenticationNotifier>(
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
              postNotifier(true).selectedPostImage != null
                  ? Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              FileImage(postNotifier(true).selectedPostImage!),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (() {
                        postNotifier(false).pickPostImage();
                      }),
                      child: Text(postNotifier(true).selectedPostImage == null
                          ? "Select Image"
                          : "Reselect Image")),
                  if (postNotifier(true).selectedPostImage != null)
                    ElevatedButton(
                        onPressed: (() {
                          postNotifier(false).removeImage();
                        }),
                        child: const Text("Remove Image")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: (() async {
                    final String useremail = await authenticationNotifier
                        .getUserEmailFromJwt(context: context);
                    debugPrint("Post email $useremail");
                    await postNotifier(false).uploadPostImage(context: context);
                    if (postNotifier(false).uploadedImageurl != null) {
                      final uploadedImagePath =
                          postNotifier(false).uploadedImageurl.toString();
                      final response = await postNotifier(false).addPost(
                        context: context,
                        postDTO: PostDTO(
                          post_title: titleController.text,
                          post_text: descriptionController.text,
                          post_images: uploadedImagePath,
                          useremail: useremail,
                        ),
                      );
                      if (response.statusCode == statusCodeCreated) {
                        Navigator.of(context).pushNamed(HomeView.routeName);
                      } else {
                        final Map<String, dynamic> parsedValue =
                            json.decode(response.body);
                        if (parsedValue['message'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            parsedValue['message'],
                          )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            response.message.toString(),
                          )));
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Image not upladed"),
                      ));
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
