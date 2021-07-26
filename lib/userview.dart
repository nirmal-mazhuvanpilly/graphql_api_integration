import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/updateuser.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserView extends StatelessWidget {
  final String _query = """
  query users{
    users{
      id
      name
      rocket
      twitter
    }
  }
  """;
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(_query),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List users = result.data["users"];
          // print(users);
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            itemCount: users.length,
            itemBuilder: (context, index) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          users.elementAt(index)["name"] ?? "-----",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.indigo,
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => UpdateUser(
                                id: users.elementAt(index)["id"] ?? "",
                                name: users.elementAt(index)["name"] ?? "",
                                rocket: users.elementAt(index)["rocket"] ?? "",
                                twitter:
                                    users.elementAt(index)["twitter"] ?? "",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "ID",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      users.elementAt(index)["id"] ?? "-----",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Rocket Name",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      users.elementAt(index)["rocket"] ?? "-----",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Twitter",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      users.elementAt(index)["twitter"] ?? "-----",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
