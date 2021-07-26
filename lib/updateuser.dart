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

  TextEditingController name_controller = TextEditingController();
  TextEditingController rocket_controller = TextEditingController();
  TextEditingController twitter_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    showLoadedValues();
    name_controller.text = widget.name ?? "";
    rocket_controller.text = widget.rocket ?? "";
    twitter_controller.text = widget.twitter ?? "";
  }

  @override
  void dispose() {
    name_controller.dispose();
    rocket_controller.dispose();
    twitter_controller.dispose();
    super.dispose();
  }

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Mutation(
                    options: MutationOptions(
                      documentNode: gql(
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
                      documentNode: gql(
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
                          if (name_controller.text.isNotEmpty &&
                              rocket_controller.text.isNotEmpty &&
                              twitter_controller.text.isNotEmpty) {
                            // print(name_controller.text);
                            // print(rocket_controller.text);
                            // print(twitter_controller.text);
                            runMutation(
                              {
                                'id': widget.id,
                                'name': name_controller.text,
                                'rocket': rocket_controller.text,
                                'twitter': twitter_controller.text,
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

                            _scaffoldKey.currentState.showSnackBar(snackBar);
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
