import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:musicap/musiccard.dart';
import 'package:musicap/player.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  MusicFinder audioplayer = new MusicFinder();
  List<Song> song;
  @override
  void initState() {
    super.initState();
    findMusic();
  }

  void findMusic() async {
    List<Song> songs = await MusicFinder.allSongs();
    songs = new List.from(songs);
    setState(() {
      song = songs;
      loading = false;
    });
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
              Icon(
                Icons.more_vert_rounded,
                color: Colors.black45,
                size: 30,
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
                          MusicCard(
                            albumart: song[0].albumArt,
                            singername: song[0].artist,
                            songname: song[0].title,
                            uri: song[0].uri,
                          ),
                          MusicCard(
                            albumart: song[0].albumArt,
                            singername: song[0].artist,
                            songname: song[0].title,
                            uri: song[0].uri,
                          ),
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
                                audioplayer.stop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Player(
                                      albumname: song[i].album,
                                      singername: song[i].artist,
                                      songname: song[i].title,
                                      uri: song[i].uri,
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
                                          image: AssetImage('assets/album.jpg'),
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
                                            song[i].title,
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
                                            song[i].artist,
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
                          itemCount: song.length,
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
