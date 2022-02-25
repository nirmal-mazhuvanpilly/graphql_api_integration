import 'package:flutter_graphql_api_integration/services/graphql_client_config.dart';

class QueriesMutations {
  Future<dynamic> getUsers() async {
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
    return await GraphQlClientConfig.instance.query(_query);
  }

  Future<dynamic> getUpComing() async {
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
    return await GraphQlClientConfig.instance.query(_query);
  }

  Future<dynamic> getHistory() async {
    final String _query = """
    query launchHistory {
  launchesPast(limit: 10) {
    mission_name
    launch_date_utc
    rocket {
      rocket_name
      rocket_type
    }
    links {
      article_link
      flickr_images
    }
  }
}
  """;
    return await GraphQlClientConfig.instance.query(_query);
  }

  Future<dynamic> addUser({String name, String rocket, String twitter}) async {
    final String _query = """
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
    Map<String, dynamic> variables = {
      "name": name,
      "rocket": rocket,
      "twitter": twitter
    };
    return await GraphQlClientConfig.instance
        .mutatation(_query, variables: variables);
  }

  Future<dynamic> deleteUser(String id) async {
    final String _query = """
      mutation deleteUser(\$id : uuid!) {
         delete_users(where: {id: {_eq: \$id}}) {
           returning {
            id
           }
       }
      }
    """;
    Map<String, dynamic> variables = {"id": id};
    return await GraphQlClientConfig.instance
        .mutatation(_query, variables: variables);
  }

  Future<dynamic> updateUser(
      {String id, String name, String rocket, String twitter}) async {
    final String _query = """
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
    Map<String, dynamic> variables = {
      "id": id,
      "name": name,
      "rocket": rocket,
      "twitter": twitter
    };
    return await GraphQlClientConfig.instance
        .mutatation(_query, variables: variables);
  }
}
