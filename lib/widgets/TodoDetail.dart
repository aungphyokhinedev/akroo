import "package:flutter/material.dart";


class TodoDetail extends StatelessWidget {
final String _id;
  TodoDetail(this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kim Saung Yaung'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
/// This is the important part, we need [Hero] widget with unique tag but same as Hero's tag in [User] widget.
              child: Hero(
                tag: "avatar_" + _id.toString(),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage('http://farm3.static.flickr.com/2602/4020504621_5224db55cf_o.jpg'),
                ),
              ),
            ),
            Text(_id,
              style: TextStyle(
                fontSize: 22
              ),
            ),
          ],
        ),
      ),
    );
  }
}