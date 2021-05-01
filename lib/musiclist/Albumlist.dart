import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicap/screens/player.dart';
import '../constants.dart' as cst;

class AlbumList extends StatefulWidget {
  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final GlobalKey<PlayerState> key = GlobalKey<PlayerState>();
  List<AlbumInfo> albums = [];
  int currentIndex = 0;
  bool loading = true;

  void getAlbums() async {
    albums = await audioQuery.getAlbums();
    setState(() {
      albums = albums;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Container(
        height: 660 * cst.responsiveCofficient(context),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemBuilder: (BuildContext context, int i) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(
                  'assets/album.jpg',
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Text(
                        albums[i].title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          itemCount: albums.length,
        ),
      ),
    );
  }
}
