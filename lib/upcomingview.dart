import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpcomingView extends StatelessWidget {
  // Example of GraphQL query
  // query is used to fetch data from API
  final String _query = """
    query launchUpcoming {
  launchesUpcoming(limit: 10) {
    id
    mission_name
    launch_date_utc
    rocket {
      rocket_name
      rocket_type
    }
    links {
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
          List launches = result.data["launchesUpcoming"];
          // print(launches);
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            itemCount: launches.length,
            itemBuilder: (context, index) {
              String date = launches
                  .elementAt(index)["launch_date_utc"]
                  .toString()
                  .substring(0, 10);
              // print(date);

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
                        launches.elementAt(index)["mission_name"] ?? "-----",
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
                      launches.elementAt(index)["rocket"]["rocket_name"] ??
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
        }
      },
    );
  }
}
