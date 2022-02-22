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

  TextEditingController nameController;
  TextEditingController rocketController;
  TextEditingController twitterController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    rocketController = TextEditingController();
    twitterController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    rocketController.dispose();
    twitterController.dispose();
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
          document: gql(
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
                      controller: nameController,
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
                      controller: rocketController,
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
                      controller: twitterController,
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
                      if (nameController.text.isNotEmpty &&
                          rocketController.text.isNotEmpty &&
                          twitterController.text.isNotEmpty) {
                        // print(name_controller.text);
                        // print(rocket_controller.text);
                        // print(twitter_controller.text);

                        runMutation({
                          'name': nameController.text,
                          'rocket': rocketController.text,
                          'twitter': twitterController.text,
                        });
                      } else {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Fields must not be empty',
                            textAlign: TextAlign.center,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
