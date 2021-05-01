import 'package:flutter/material.dart';
import 'package:musicap/musiclist/Albumlist.dart';
import 'package:musicap/musiclist/artistlist.dart';
import 'package:musicap/musiclist/songsList.dart';
import '../constants.dart' as cst;

class MusicGallary extends StatefulWidget {
  @override
  _MusicGallaryState createState() => _MusicGallaryState();
}

class _MusicGallaryState extends State<MusicGallary>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: AppBar(
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
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: Color.fromRGBO(38, 78, 139, 1),
                indicatorWeight: 2,
                tabs: [
                  Tab(
                    child: Text(
                      'Songs',
                      style: TextStyle(
                        fontSize: 19 * cst.responsiveCofficient(context),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Artist',
                      style: TextStyle(
                        fontSize: 19 * cst.responsiveCofficient(context),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Album',
                      style: TextStyle(
                        fontSize: 19 * cst.responsiveCofficient(context),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                controller: _controller,
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
                Size.fromHeight(120 * cst.responsiveCofficient(context)),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              SongList(),
              ArtistList(),
              AlbumList(),
            ],
          ),
        ),
      ),
    );
  }
}
