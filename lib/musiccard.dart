import 'package:flutter/material.dart';

class MusicCard extends StatefulWidget {
  final songname;
  final singername;
  final albumart;
  final uri;

  const MusicCard(
      {Key key, this.songname, this.singername, this.albumart, this.uri})
      : super(key: key);
  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.albumart);
    return Container(
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white54,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.songname,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    ),
                    Expanded(
                      child: Text(
                        widget.singername,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
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
    );
  }
}
