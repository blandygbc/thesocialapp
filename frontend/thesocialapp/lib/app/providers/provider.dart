import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:thesocialapp/core/notifier/authentication_notifier.dart';
import 'package:thesocialapp/core/notifier/post_notifier.dart';
import 'package:thesocialapp/core/notifier/utility_notifier.dart';

List<SingleChildWidget> providers = [...remoteProvider];

List<SingleChildWidget> remoteProvider = [
  ChangeNotifierProvider(
    create: (_) => AuthenticationNotifier(),
  ),
  ChangeNotifierProvider(
    create: (_) => UtilityNotifier(),
  ),
  ChangeNotifierProvider(
    create: (_) => PostNotifier(),
  )
];
