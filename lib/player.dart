import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  final songname;
  final singername;
  final albumname;
  final uri;

  const Player(
      {Key key, this.songname, this.singername, this.albumname, this.uri})
      : super(key: key);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
              ),
              onPressed: () {},
            ),
            title: Text(
              'Player',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 25,
              ),
            ),
            actions: [
              Icon(
                Icons.more_vert,
                color: Colors.black45,
              ),
            ],
          ),
          preferredSize: Size.fromHeight(70),
        ),
      ),
    );
  }
}
