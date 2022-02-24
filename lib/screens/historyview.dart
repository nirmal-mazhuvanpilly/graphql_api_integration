import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/providers/spacex_provider.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatefulWidget {
  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<SpaceXProvider>(context, listen: false).fetchHistory());
    super.initState();
  }

  static const _noImage =
      "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg";

  @override
  Widget build(BuildContext context) {
    return Consumer<SpaceXProvider>(builder: (context, value, child) {
      if (value?.historyModel?.data?.launchesPast == null) {
        return Center(
          child: CupertinoActivityIndicator(),
        );
      }
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 25, bottom: 10),
        itemCount: value.historyModel.data.launchesPast.length,
        itemBuilder: (context, index) {
          String date = value.historyModel.data.launchesPast
              .elementAt(index)
              .launchDateUtc
              .toString()
              .substring(0, 10);

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 15, right: 30, bottom: 10),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 20,
                          offset: Offset(0, 10)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value.historyModel.data.launchesPast
                              .elementAt(index)
                              .missionName ??
                          "-----",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Rocket",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      value.historyModel.data.launchesPast
                              .elementAt(index)
                              .rocket
                              .rocketName ??
                          "-----",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Launch Date",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date ?? "-----",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.shade400,
                          Colors.grey.shade300,
                          Colors.grey.shade400
                        ]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: value.historyModel.data.launchesPast
                              .elementAt(index)
                              .links
                              .flickrImages
                              .isEmpty
                          ? _noImage
                          : value.historyModel.data.launchesPast
                              .elementAt(index)
                              .links
                              .flickrImages
                              .elementAt(1),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
