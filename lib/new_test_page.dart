import 'package:flutter/cupertino.dart';
import 'package:safeguardher/utils/util.dart';

class NewTestPage extends StatelessWidget {
  const NewTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBarTitle: "New Test Page",
      bodyStack: Text("FUCK YOU"),
    );
  }
}
