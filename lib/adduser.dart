import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  // Example of GraphQL mutation
  // mutation is used to modify server-side data
  String insertUser() {
    return """
    mutation insertUser(\$name: String!, \$rocket: String!, \$twitter: String!) {
      insert_users(objects: {
        name: \$name,
        rocket: \$rocket,
        twitter: \$twitter,
      }) {
        returning {
          id
          name
          twitter
          rocket
        }
      }
    }
    """;
  }

  TextEditingController name_controller;
  TextEditingController rocket_controller;
  TextEditingController twitter_controller;

  @override
  void initState() {
    super.initState();
    name_controller = TextEditingController();
    rocket_controller = TextEditingController();
    twitter_controller = TextEditingController();
  }

  @override
  void dispose() {
    name_controller.dispose();
    rocket_controller.dispose();
    twitter_controller.dispose();
    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("New User"),
      ),
      body: Mutation(
        options: MutationOptions(
          documentNode: gql(
            insertUser(),
          ),
          fetchPolicy: FetchPolicy.noCache,
          onCompleted: (data) {
            print("Oncompleted Data : $data");
            Navigator.pop(context);
          },
        ),
        builder: (runMutation, result) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: name_controller,
                      decoration: InputDecoration(
                        hintText: "Name",
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: rocket_controller,
                      decoration: InputDecoration(
                        hintText: "Rocket",
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: twitter_controller,
                      decoration: InputDecoration(
                        hintText: "Twitter",
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (name_controller.text.isNotEmpty &&
                          rocket_controller.text.isNotEmpty &&
                          twitter_controller.text.isNotEmpty) {
                        // print(name_controller.text);
                        // print(rocket_controller.text);
                        // print(twitter_controller.text);

                        runMutation({
                          'name': name_controller.text,
                          'rocket': rocket_controller.text,
                          'twitter': twitter_controller.text,
                        });
                      } else {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Fields must not be empty',
                            textAlign: TextAlign.center,
                          ),
                        );

                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      }
                    },
                    child: Text("Add User"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
