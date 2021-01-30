import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/playArenaModel.dart';
import 'package:flutter_assignment/Repositories/mainRepository.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _mainRepo = MainRepository();
  Future<List<PlayArenaModel>> _playArenaList;

  @override
  void initState() {
    super.initState();
    _playArenaList = _mainRepo.getArenaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Play Arena',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<PlayArenaModel>>(
              future: _playArenaList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (!snapshot.hasData &&
                    snapshot.connectionState != ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: Text("Something went wrong"),
                    ),
                  );
                }
                if (snapshot.hasData &&
                    snapshot.connectionState != ConnectionState.waiting) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return TheArena(
                          playArenaModel: snapshot.data[index],
                        );
                      },
                    ),
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}

class TheArena extends StatelessWidget {
  final PlayArenaModel playArenaModel;

  const TheArena({Key key, this.playArenaModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Name ${playArenaModel.name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                " (${playArenaModel.sports.name})",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Open on Days: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                height: 16,
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playArenaModel.dayOfWeeksOpen.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) {
                    return Text(
                        playArenaModel.dayOfWeeksOpen[i].toString() + ", ");
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Open Time: '),
                  Text(playArenaModel.openTime),
                ],
              ),
              Row(
                children: [
                  Text('Close Time: '),
                  Text(playArenaModel.closeTime),
                ],
              ),
            ],
          ),
          playArenaModel.images != null
              ? Container(
                  height: 100,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: playArenaModel.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: CachedNetworkImage(
                            imageUrl: playArenaModel.images[index]),
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
