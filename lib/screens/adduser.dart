import 'package:flutter/material.dart';
import 'package:flutter_graphql_api_integration/providers/spacex_provider.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
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
    final _spacex = Provider.of<SpaceXProvider>(context, listen: false);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("New User"),
        ),
        body: Center(
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
                      _spacex
                          .addUser(
                              name: nameController.text,
                              rocket: rocketController.text,
                              twitter: twitterController.text)
                          .then((value) {
                        _spacex
                            .fetchUsers()
                            .then((value) => Navigator.of(context).pop());
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
        ));
  }
}
