import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/topic.dart';

import 'components/body.dart';

class TopicPage extends StatefulWidget {
  final Topic currentTopic;

  const TopicPage({Key? key, required this.currentTopic}) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicPage(currentTopic);
}

class _TopicPage extends State<TopicPage> {
  final Topic currentTopic;

  _TopicPage(this.currentTopic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: Center(child: Body(currentTopic: currentTopic))
    );
  }
}
