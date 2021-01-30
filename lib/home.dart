import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/playArenaModel.dart';
import 'package:flutter_assignment/Repositories/mainRepository.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scrollContoller = ScrollController();
  final _mainRepo = MainRepository();
  final _streamController = StreamController<List<PlayArenaModel>>();
  Stream<List<PlayArenaModel>> _playArenaList;
  int _iniCount = 10;

  @override
  void initState() {
    super.initState();
    _playArenaList = _mainRepo.getArenaList(_iniCount).asStream();
    _streamController.addStream(_playArenaList);
    _scrollContoller.addListener(() async {
      if (_scrollContoller.position.atEdge) {
        if (_scrollContoller.position.pixels == 0) {
          debugPrint("at top");
        } else {
          debugPrint("reached last");
          _iniCount += 10;
          debugPrint(_iniCount.toString());
          final _newPlayArenaList = await _mainRepo.getArenaList(_iniCount);
          _streamController.add(_newPlayArenaList);
        }
      }
    });
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
          StreamBuilder<List<PlayArenaModel>>(
              stream: _streamController.stream,
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
                      controller: _scrollContoller,
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
