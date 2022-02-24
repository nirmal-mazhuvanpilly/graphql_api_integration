import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/providers/spacex_provider.dart';
import 'package:provider/provider.dart';

class UpcomingView extends StatefulWidget {
  @override
  State<UpcomingView> createState() => _UpcomingViewState();
}

class _UpcomingViewState extends State<UpcomingView> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<SpaceXProvider>(context, listen: false).fetchUpComing());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpaceXProvider>(
      builder: (context, value, child) {
        if (value?.upComingModel?.data?.launchesUpcoming == null) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          itemCount: value.upComingModel.data.launchesUpcoming.length,
          itemBuilder: (context, index) {
            String date = value.upComingModel.data.launchesUpcoming
                .elementAt(index)
                .launchDateUtc
                .toString()
                .substring(0, 10);
            return Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
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
                  Center(
                    child: Text(
                      value.upComingModel.data.launchesUpcoming
                              .elementAt(index)
                              .missionName ??
                          "-----",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    "Rocket",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value.upComingModel.data.launchesUpcoming
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
            );
          },
        );
      },
    );
  }
}
