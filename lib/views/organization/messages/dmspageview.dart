import 'package:flutter/material.dart';
import 'local_widgets/chatroomlist.dart';

class DMsPageView extends StatefulWidget {
  DMsPageView({Key key}) : super(key: key);

  @override
  _DMsPageViewState createState() => _DMsPageViewState();
}

class _DMsPageViewState extends State<DMsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ChatRoomListView());
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       'Unreads',
    //       style: Theme.of(context).textTheme.headline4,
    //     ),
    //     ChatRoomListView(),
    //     Text(
    //       'People',
    //       style: Theme.of(context).textTheme.headline4,
    //     ),
    //     ChatRoomListView(),
    //   ],
    // ),
  }
}
