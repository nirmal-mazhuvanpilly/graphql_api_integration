import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlClientConfig {
  GraphQlClientConfig._private();
  static final GraphQlClientConfig _instance = GraphQlClientConfig._private();
  static GraphQlClientConfig get instance => _instance;

  static const baseUrl = 'https://api.spacex.land/graphql/';

  final HttpLink _link = HttpLink(baseUrl);
  GraphQLClient _graphQLClient;

  Future<void> configGraphQL() async {
    _graphQLClient =
        GraphQLClient(link: _link, cache: GraphQLCache(store: InMemoryStore()));
  }

  Future<dynamic> query(String query) async {
    try {
      final QueryResult queryResult = await _graphQLClient
          .query(
        QueryOptions(
            document: gql(query), fetchPolicy: FetchPolicy.networkOnly),
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw NetworkException(
            uri: Uri(path: baseUrl), message: "Check Your Internet Connection");
      });

      if (queryResult.exception != null && queryResult.data == null) {
        if (queryResult.exception.graphqlErrors.isNotEmpty) {
          return <String, dynamic>{
            'status': 'error',
            'message': queryResult.exception?.graphqlErrors[0].message ??
                'Something went wrong',
            'extensions': queryResult.exception?.graphqlErrors[0].extensions
          };
        } else {
          return <String, dynamic>{
            'status': 'error',
            'message':
                queryResult.exception?.linkException?.originalException ??
                    'Something went wrong',
            'extensions': queryResult.exception?.graphqlErrors[0].extensions
          };
        }
      }
      return queryResult.data;
    } catch (e) {
      return <String, dynamic>{
        'status': 'error',
        'message': 'Something went wrong',
        'extensions': null
      };
    }
  }

  Future<dynamic> mutatation(String query) async {
    try {
      final QueryResult queryResult = await _graphQLClient
          .mutate(
        MutationOptions(
            document: gql(query), fetchPolicy: FetchPolicy.networkOnly),
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw NetworkException(
            uri: Uri(path: baseUrl), message: "Check Your Internet Connection");
      });

      if (queryResult.exception != null && queryResult.data == null) {
        if (queryResult.exception.graphqlErrors.isNotEmpty) {
          return <String, dynamic>{
            'status': 'error',
            'message': queryResult.exception?.graphqlErrors[0].message ??
                'Something went wrong',
            'extensions': queryResult.exception?.graphqlErrors[0].extensions
          };
        } else {
          return <String, dynamic>{
            'status': 'error',
            'message':
                queryResult.exception?.linkException?.originalException ??
                    'Something went wrong',
            'extensions': queryResult.exception?.graphqlErrors[0].extensions
          };
        }
      }
      return queryResult.data;
    } catch (e) {
      return <String, dynamic>{
        'status': 'error',
        'message': 'Something went wrong',
        'extensions': null
      };
    }
  }
}
