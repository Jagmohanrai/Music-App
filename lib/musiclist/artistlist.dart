import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicap/screens/player.dart';
import 'package:musicap/subscreens/artistsubscreen.dart';
import '../constants.dart' as cst;

class ArtistList extends StatefulWidget {
  @override
  _ArtistListState createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final GlobalKey<PlayerState> key = GlobalKey<PlayerState>();
  List<ArtistInfo> artists = [];
  int currentIndex = 0;
  bool loading = true;

  void getArtists() async {
    artists = await audioQuery.getArtists();
    setState(() {
      artists = artists;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 660 * cst.responsiveCofficient(context),
      child: ListView.builder(
        itemBuilder: (context, i) => Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10 * cst.responsiveCofficient(context),
            horizontal: 10 * cst.responsiveCofficient(context),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistSubScreen(
                    artistId: artists[i].id,
                    artistname: artists[i].name,
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
                        image: AssetImage('assets/album.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200 * cst.responsiveCofficient(context),
                        child: Text(
                          artists[i].name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 16 * cst.responsiveCofficient(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10 * cst.responsiveCofficient(context),
                      ),
                      Container(
                        width: 200 * cst.responsiveCofficient(context),
                        child: Text(
                          artists[i].numberOfTracks,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 16 * cst.responsiveCofficient(context),
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
        itemCount: artists.length,
      ),
    );
  }
}
