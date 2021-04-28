import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicap/player.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  // MusicFinder audioplayer = new MusicFinder();
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final GlobalKey<PlayerState> key = GlobalKey<PlayerState>();
  List<SongInfo> songs = [];
  // List<Song> song;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getSongs();
  }

  void getSongs() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
      loading = false;
    });
  }

  // void findMusic() async {
  //   List<Song> songs = await MusicFinder.allSongs();
  //   songs = new List.from(songs);
  //   setState(() {
  //     song = songs;
  //     loading = false;
  //   });
  // }

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
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            leading: Icon(
              Icons.menu,
              color: Colors.black45,
              size: 30,
            ),
            centerTitle: true,
            title: Text(
              'Discover',
              style: TextStyle(color: Colors.black45, fontSize: 25),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black45,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Welcome !',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search music, album.....',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.search_rounded,
                                color: Colors.black45,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Music Trending',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Show more',
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 230,
                            width: 170,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    'assets/album.jpg',
                                  )),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Align(
                              alignment: Alignment(0, 0.88),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: InkWell(
                                  onTap: () {
                                    currentIndex = 1;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Player(
                                          songInfo: songs[1],
                                          changetrack: changetrack,
                                          key: key,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white60,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 4.0,
                                                  left: 4.0,
                                                ),
                                                child: Text(
                                                  songs[3].title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 4.0, left: 4.0),
                                                child: Text(
                                                  songs[1].artist,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 230,
                            width: 170,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    'assets/album.jpg',
                                  )),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Align(
                              alignment: Alignment(0, 0.88),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: InkWell(
                                  onTap: () {
                                    currentIndex = 3;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Player(
                                          songInfo: songs[3],
                                          changetrack: changetrack,
                                          key: key,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white60,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 4.0,
                                                  left: 4.0,
                                                ),
                                                child: Text(
                                                  songs[3].title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 4.0, left: 4.0),
                                                child: Text(
                                                  songs[3].artist,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recently',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Popular',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Similer',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 500,
                        child: ListView.builder(
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: InkWell(
                              onTap: () {
                                currentIndex = i;
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
                                height: 100,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            songs[i].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 200,
                                          child: Text(
                                            songs[i].artist,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: 16,
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
