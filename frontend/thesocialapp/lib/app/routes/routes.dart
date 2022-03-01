import 'package:thesocialapp/meta/views/authentication/login_view.dart';
import 'package:thesocialapp/meta/views/authentication/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:thesocialapp/meta/views/decider_view/decider_view.dart';
import 'package:thesocialapp/meta/views/home_view/home_view.dart';
import 'package:thesocialapp/meta/views/post_view/add_post_view.dart';
import 'package:thesocialapp/meta/views/splash_view/splash_view.dart';
import 'package:thesocialapp/meta/views/story_view/sotry_details_view.dart';
import 'package:thesocialapp/meta/views/story_view/story_add_view.dart';
import 'package:thesocialapp/meta/views/story_view/story_list_view.dart';

final Map<String, WidgetBuilder> routes = {
  SignupView.routeName: (context) => const SignupView(),
  LoginView.routeName: (context) => const LoginView(),
  SplashView.routeName: (context) => const SplashView(),
  HomeView.routeName: (context) => const HomeView(),
  DeciderView.routeName: (context) => const DeciderView(),
  AddPostView.routeName: (context) => const AddPostView(),
  StoryAddView.routeName: (context) => const StoryAddView(),
  StoryDetailsView.routeName: (context) => const StoryDetailsView(),
  StoryListView.routeName: (context) => const StoryListView(),
};
