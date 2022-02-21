import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chatt/page/channel_list_page.dart';
import 'api/stream_api.dart';
import 'config.dart';
import 'page/channel_page.dart';

Future main() async {
  final client = StreamChatClient(Config.apiKey, logLevel: Level.SEVERE);

  // await StreamApi.initUser(
  //   client,
  //   username: 'meriem',
  //   image:
  //       'https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png',
  //   id: Config.idEmily,
  //   token: Config.tokenEmily,
  // );

  await StreamApi.initUser(
    client,
    username: 'Peter',
    image:
        'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-260nw-562077406.jpg',
    id: Config.idPeter,
    token: Config.tokenPeter,
  );

  // final channel = await StreamApi.createChannel(client,
  //     type: 'messaging',
  //     name: 'BM 1 ',
  //     id: 'sample7',
  //     image:
  //         'https://img-19.ccm2.net/cI8qqj-finfDcmx6jMK6Vr-krEw=/1500x/smart/b829396acc244fd484c5ddcdcb2b08f3/ccmcms-commentcamarche/20494859.jpg',
  //     idMembers: [Config.idEmily, Config.idPeter]);

  final channel = await StreamApi.watchChannel(
    client,
    type: 'messaging',
    id: 'sample7',
  );
  // channel.delete();
  runApp(MyApp(
    client: client,
    channel: channel,
  ));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;
  const MyApp({Key? key, required this.client, required this.channel})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          client: client,
          child: widget,
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamChannel(
        channel: channel,
        child: MyHomePage(
          title: 'Flutter Demo Home Page',
          client: client,
          channel: channel,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final StreamChatClient client;
  final Channel channel;
  const MyHomePage(
      {required this.title, required this.client, required this.channel});
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamChat(
        child: StreamChannel(
          child: ChannelListPage(),
          channel: widget.channel,
        ),
        client: widget.client,
      ),
    );
  }
}
