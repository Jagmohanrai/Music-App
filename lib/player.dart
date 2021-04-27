import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  final songname;
  final singername;
  final albumname;
  final uri;
  final duration;

  const Player(
      {Key key,
      this.songname,
      this.singername,
      this.albumname,
      this.uri,
      this.duration})
      : super(key: key);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  MusicFinder audioPlayer = new MusicFinder();
  bool playing = true;

  double duration = 0.0;

  Future _playLocal(String uri) async {
    playing = true;
    setState(() {});
    final result = await audioPlayer.play(uri, isLocal: true);
  }

  @override
  void initState() {
    super.initState();
    _playLocal(widget.uri);
  }

  Future pause() async {
    final result = await audioPlayer.pause();
    playing = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black45,
              ),
              onPressed: () {},
            ),
            centerTitle: true,
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
        body: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 50,
                      child: Divider(
                        thickness: 5,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Listening to',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/album.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 300,
                          child: Text(
                            widget.songname,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black45,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.singername + "-" + widget.albumname,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 450,
                    child: Slider(
                      activeColor: Color.fromRGBO(38, 78, 139, 1),
                      inactiveColor: Colors.black38,
                      value: duration,
                      onChanged: (v) {
                        setState(() {
                          duration = v;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1:20",
                          style: TextStyle(fontSize: 17, color: Colors.black45),
                        ),
                        Text(
                          widget.duration,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.shuffle,
                        size: 40,
                        color: Colors.black45,
                      ),
                      InkWell(
                        onTap: () {
                          audioPlayer.seek(-10.0);
                        },
                        child: Icon(
                          Icons.skip_previous,
                          size: 40,
                          color: Colors.black45,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          playing ? pause() : _playLocal(widget.uri);
                        },
                        child: Icon(
                          playing
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          size: 70,
                          color: Color.fromRGBO(38, 78, 139, 1),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          audioPlayer.seek(10.0);
                        },
                        child: Icon(
                          Icons.skip_next,
                          size: 40,
                          color: Colors.black45,
                        ),
                      ),
                      Icon(
                        Icons.queue_music,
                        color: Colors.black45,
                        size: 40,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
