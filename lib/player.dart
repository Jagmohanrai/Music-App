import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicap/songsList.dart';
import 'constants.dart' as cst;

class Player extends StatefulWidget {
  SongInfo songInfo;
  Function changetrack;
  final GlobalKey<PlayerState> key;

  Player({
    this.songInfo,
    this.changetrack,
    this.key,
  }) : super(key: key);
  @override
  PlayerState createState() => PlayerState();
}

class PlayerState extends State<Player> {
  MusicFinder audioPlayer = new MusicFinder();
  AudioPlayer player = new AudioPlayer();

  bool playing = false;

  double duration = 0.0;
  double minimumValue = 0.0;
  double maxValue = 0.0;
  double currentvalue = 0.0;
  String currentTime = '', endTime = '';

  // Future _playLocal(String uri) async {
  //   playing = true;
  //   setState(() {});
  //   final result = await audioPlayer.play(uri, isLocal: true);
  // }

  void playSong(SongInfo songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.uri);
    currentvalue = minimumValue;
    maxValue = player.duration.inMilliseconds.toDouble();
    setState(() {
      currentTime = getDuration(currentvalue);
      endTime = getDuration(maxValue);
    });
    playing = false;
    changeStatus();
    player.positionStream.listen((duration) {
      currentvalue = duration.inMilliseconds.toDouble();
      setState(() {
        currentTime = getDuration(currentvalue);
      });
    });
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((e) => e.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  void initState() {
    super.initState();
    playSong(widget.songInfo);
  }

  void dispose() {
    super.dispose();
    player?.dispose();
  }

  void changeStatus() {
    setState(() {
      playing = !playing;
    });
    if (playing) {
      player.play();
    } else {
      player.pause();
    }
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(
                  right: 8.0 * cst.responsiveCofficient(context)),
              child: Text(
                'Player',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 25 * cst.responsiveCofficient(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    right: 10.0 * cst.responsiveCofficient(context)),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          preferredSize:
              Size.fromHeight(70 * cst.responsiveCofficient(context)),
        ),
        body: Padding(
          padding:
              EdgeInsets.only(top: 10.0 * cst.responsiveCofficient(context)),
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
                topLeft:
                    Radius.circular(50 * cst.responsiveCofficient(context)),
                topRight:
                    Radius.circular(50 * cst.responsiveCofficient(context)),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * cst.responsiveCofficient(context)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8.0 * cst.responsiveCofficient(context)),
                    child: Container(
                      width: 50 * cst.responsiveCofficient(context),
                      child: Divider(
                        thickness: 5 * cst.responsiveCofficient(context),
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15 * cst.responsiveCofficient(context),
                  ),
                  Text(
                    'Listening to',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28 * cst.responsiveCofficient(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 50 * cst.responsiveCofficient(context),
                  ),
                  Container(
                    height: 320 * cst.responsiveCofficient(context),
                    width: 320 * cst.responsiveCofficient(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/album.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50 * cst.responsiveCofficient(context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20 * cst.responsiveCofficient(context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 300 * cst.responsiveCofficient(context),
                          child: Text(
                            widget.songInfo.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    20 * cst.responsiveCofficient(context),
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
                    height: 10 * cst.responsiveCofficient(context),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20 * cst.responsiveCofficient(context)),
                      child: Text(
                        widget.songInfo.artist + "-" + widget.songInfo.album,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18 * cst.responsiveCofficient(context),
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 450 * cst.responsiveCofficient(context),
                    child: Slider(
                      activeColor: Color.fromRGBO(38, 78, 139, 1),
                      inactiveColor: Colors.black38,
                      min: minimumValue,
                      max: maxValue,
                      value: currentvalue,
                      onChanged: (v) {
                        setState(() {
                          currentvalue = v;
                          player.seek(
                              Duration(milliseconds: currentvalue.round()));
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20 * cst.responsiveCofficient(context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentTime,
                          style: TextStyle(
                              fontSize: 17 * cst.responsiveCofficient(context),
                              color: Colors.black45),
                        ),
                        Text(
                          endTime,
                          style: TextStyle(
                            fontSize: 17 * cst.responsiveCofficient(context),
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30 * cst.responsiveCofficient(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.shuffle,
                        size: 40 * cst.responsiveCofficient(context),
                        color: Colors.black45,
                      ),
                      InkWell(
                        onTap: () {
                          widget.changetrack(false);
                        },
                        child: Icon(
                          Icons.skip_previous,
                          size: 40 * cst.responsiveCofficient(context),
                          color: Colors.black45,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeStatus();
                        },
                        child: Icon(
                          playing
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_fill_rounded,
                          size: 70 * cst.responsiveCofficient(context),
                          color: Color.fromRGBO(38, 78, 139, 1),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.changetrack(true);
                        },
                        child: Icon(
                          Icons.skip_next,
                          size: 40 * cst.responsiveCofficient(context),
                          color: Colors.black45,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongList(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.queue_music,
                          color: Colors.black45,
                          size: 40 * cst.responsiveCofficient(context),
                        ),
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
