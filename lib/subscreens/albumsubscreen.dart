import 'package:flutter/material.dart';
import 'package:musicap/constants.dart' as cst;
import 'dart:io';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicap/screens/player.dart';

class AlbumSubScreen extends StatefulWidget {
  final ablumId;
  final albumname;

  const AlbumSubScreen({Key key, this.ablumId, this.albumname})
      : super(key: key);
  @override
  _AlbumSubScreenState createState() => _AlbumSubScreenState();
}

class _AlbumSubScreenState extends State<AlbumSubScreen> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final GlobalKey<PlayerState> key = GlobalKey<PlayerState>();
  List<SongInfo> songs = [];

  void getSongs() async {
    songs = await audioQuery.getSongsFromAlbum(albumId: widget.ablumId);
    setState(
      () {
        songs = songs;
      },
    );
  }

  int currentIndex = 0;
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

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(70 * cst.responsiveCofficient(context)),
          child: AppBar(
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black45,
                size: 30 * cst.responsiveCofficient(context),
              ),
            ),
            centerTitle: true,
            title: Text(
              'Album Songs',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 25 * cst.responsiveCofficient(context)),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    right: 10.0 * cst.responsiveCofficient(context)),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black45,
                  size: 30 * cst.responsiveCofficient(context),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20 * cst.responsiveCofficient(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20 * cst.responsiveCofficient(context),
              ),
              Text(
                widget.albumname,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25 * cst.responsiveCofficient(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20 * cst.responsiveCofficient(context),
              ),
              Container(
                height: 650 * cst.responsiveCofficient(context),
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
                          return count++ == 3;
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
    );
  }
}
