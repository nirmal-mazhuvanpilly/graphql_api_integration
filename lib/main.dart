import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuring GraphQL Client
  final HttpLink link = HttpLink(uri: 'https://api.spacex.land/graphql/');
  GraphQLClient graphQLClient =
      GraphQLClient(link: link, cache: InMemoryCache());
  ValueNotifier<GraphQLClient> client = ValueNotifier(graphQLClient);

  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  MyApp({this.client});
  @override
  Widget build(BuildContext context) {
    // Providing GraphQLProvider widget at the root of the program
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
