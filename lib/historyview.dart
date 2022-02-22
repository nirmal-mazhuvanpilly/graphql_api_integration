import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HistoryView extends StatelessWidget {
  // Example of GraphQL query
  // query is used to fetch data from API
  final String _query = """
    query launchHistory {
  launchesPast(limit: 10) {
    mission_name
    launch_date_utc
    rocket {
      rocket_name
      rocket_type
    }
    links {
      article_link
      flickr_images
    }
  }
}
  """;
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(_query)),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          List history = result.data["launchesPast"];
          // print(history);
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            itemCount: history.length,
            itemBuilder: (context, index) {
              String date = history
                  .elementAt(index)["launch_date_utc"]
                  .toString()
                  .substring(0, 10);
              // print(date);

              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(left: 15, right: 30, bottom: 10),
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
                          history.elementAt(index)["mission_name"] ?? "-----",
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
                          history.elementAt(index)["rocket"]["rocket_name"] ??
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
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: history
                                .elementAt(index)["links"]["flickr_images"]
                                .isEmpty
                            ? "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"
                            : history.elementAt(index)["links"]["flickr_images"]
                                [1],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
