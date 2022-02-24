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
}
