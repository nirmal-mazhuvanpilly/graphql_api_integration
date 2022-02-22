import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateUser extends StatefulWidget {
  final String id;
  final String name;
  final String rocket;
  final String twitter;

  UpdateUser({
    this.id,
    this.name,
    this.rocket,
    this.twitter,
  });
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  void showLoadedValues() {
    print(widget.id);
    print(widget.name);
    print(widget.rocket);
    print(widget.twitter);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController rocketController = TextEditingController();
  TextEditingController twitterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showLoadedValues();
    nameController.text = widget.name ?? "";
    rocketController.text = widget.rocket ?? "";
    twitterController.text = widget.twitter ?? "";
  }

  @override
  void dispose() {
    nameController.dispose();
    rocketController.dispose();
    twitterController.dispose();
    super.dispose();
  }

  // Example of GraphQL mutation
  // mutation is used to modify server-side data
  String updateUser() {
    return """
      mutation updateUser(\$id: uuid!, \$name: String!, \$rocket: String!, \$twitter: String!){
        update_users(_set:{name: \$name, rocket: \$rocket, twitter: \$twitter}, where: {id: {_eq: \$id}}){
          returning {
            id
            name
            rocket
            twitter
          }
        }
      }
    """;
  }

  // Example of GraphQL mutation
  // mutation is used to modify server-side data
  String deleteUser() {
    return """
      mutation deleteUser(\$id : uuid!) {
         delete_users(where: {id: {_eq: \$id}}) {
           returning {
            id
           }
       }
      }
    """;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Update User"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
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
                child: TextFormField(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Mutation(
                    options: MutationOptions(
                      document: gql(
                        deleteUser(),
                      ),
                      fetchPolicy: FetchPolicy.noCache,
                      onCompleted: (data) {
                        print("Oncompleted Data : $data");
                        Navigator.pop(context);
                      },
                    ),
                    builder: (runMutation, result) {
                      return ElevatedButton(
                        onPressed: () {
                          runMutation(
                            {
                              'id': widget.id,
                            },
                          );
                        },
                        child: Text("Delete User"),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  Mutation(
                    options: MutationOptions(
                      document: gql(
                        updateUser(),
                      ),
                      fetchPolicy: FetchPolicy.noCache,
                      onCompleted: (data) {
                        print("Oncompleted Data : $data");
                        Navigator.pop(context);
                      },
                    ),
                    builder: (runMutation, result) {
                      return ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              rocketController.text.isNotEmpty &&
                              twitterController.text.isNotEmpty) {
                            // print(name_controller.text);
                            // print(rocket_controller.text);
                            // print(twitter_controller.text);
                            runMutation(
                              {
                                'id': widget.id,
                                'name': nameController.text,
                                'rocket': rocketController.text,
                                'twitter': twitterController.text,
                              },
                            );
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
                        child: Text("Update User"),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
