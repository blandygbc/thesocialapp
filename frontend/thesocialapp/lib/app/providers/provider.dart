import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:thesocialapp/core/api/notifier/authentication_notifier.dart';
import 'package:thesocialapp/core/api/notifier/utility_notifier.dart';

List<SingleChildWidget> providers = [...remoteProvider];

List<SingleChildWidget> remoteProvider = [
  ChangeNotifierProvider(
    create: (_) => AuthenticationNotifier(),
  ),
  ChangeNotifierProvider(
    create: (_) => UtilityNotifier(),
  )
];
