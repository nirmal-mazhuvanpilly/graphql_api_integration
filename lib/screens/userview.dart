import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/providers/spacex_provider.dart';
import 'package:flutter_graphql_api_integration/screens/updateuser.dart';
import 'package:provider/provider.dart';

class UserView extends StatefulWidget {
  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    Future.microtask(
        () => Provider.of<SpaceXProvider>(context, listen: false).fetchUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpaceXProvider>(
      builder: (context, value, child) {
        if (value?.usersModel?.data?.users == null) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          itemCount: value.usersModel.data.users.length,
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
                    children: [
                      Text(
                        value.usersModel.data.users.elementAt(index).name ??
                            "-----",
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
                              id: value.usersModel.data.users
                                      .elementAt(index)
                                      .id ??
                                  "",
                              name: value.usersModel.data.users
                                      .elementAt(index)
                                      .name ??
                                  "",
                              rocket: value.usersModel.data.users
                                      .elementAt(index)
                                      .rocket ??
                                  "",
                              twitter: value.usersModel.data.users
                                      .elementAt(index)
                                      .twitter ??
                                  "",
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
                    value.usersModel.data.users.elementAt(index).id ?? "-----",
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
                    value.usersModel.data.users.elementAt(index).rocket ??
                        "-----",
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
                    value.usersModel.data.users.elementAt(index).twitter ??
                        "-----",
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
      },
    );
  }
}
