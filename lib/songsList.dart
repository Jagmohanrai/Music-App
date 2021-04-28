import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicap/player.dart';
import 'constants.dart' as cst;

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final GlobalKey<PlayerState> key = GlobalKey<PlayerState>();
  List<SongInfo> songs = [];
  int currentIndex = 0;

  void getSongs() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  void changetrack(bool isnext) {
    if (isnext) {
      if (currentIndex != songs.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    key.currentState.playSong(songs[currentIndex]);
  }

  bool loading = true;
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
                'Musics',
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
          padding: EdgeInsets.symmetric(
              horizontal: 20 * cst.responsiveCofficient(context)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20 * cst.responsiveCofficient(context),
                ),
                Text(
                  'Music list',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28 * cst.responsiveCofficient(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20 * cst.responsiveCofficient(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Songs',
                      style: TextStyle(
                        fontSize: 19 * cst.responsiveCofficient(context),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Artist',
                      style: TextStyle(
                        fontSize: 19 * cst.responsiveCofficient(context),
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Album',
                      style: TextStyle(
                        fontSize: 19 * cst.responsiveCofficient(context),
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Playlist',
                      style: TextStyle(
                        fontSize: 19 * cst.responsiveCofficient(context),
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20 * cst.responsiveCofficient(context),
                ),
                Container(
                  height: 660 * cst.responsiveCofficient(context),
                  child: ListView.builder(
                    itemBuilder: (context, i) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10 * cst.responsiveCofficient(context),
                        horizontal: 10 * cst.responsiveCofficient(context),
                      ),
                      child: InkWell(
                        onTap: () {
                          currentIndex = i;
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Player(
                                songInfo: songs[i],
                                changetrack: changetrack,
                                key: key,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100 * cst.responsiveCofficient(context),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 90 * cst.responsiveCofficient(context),
                                width: 80 * cst.responsiveCofficient(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      25 * cst.responsiveCofficient(context)),
                                  image: DecorationImage(
                                    image: songs[i].albumArtwork == null
                                        ? AssetImage('assets/album.jpg')
                                        : FileImage(
                                            File(songs[i].albumArtwork),
                                          ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        200 * cst.responsiveCofficient(context),
                                    child: Text(
                                      songs[i].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 16 *
                                            cst.responsiveCofficient(context),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        10 * cst.responsiveCofficient(context),
                                  ),
                                  Container(
                                    width:
                                        200 * cst.responsiveCofficient(context),
                                    child: Text(
                                      songs[i].artist,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 16 *
                                            cst.responsiveCofficient(context),
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: songs.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
