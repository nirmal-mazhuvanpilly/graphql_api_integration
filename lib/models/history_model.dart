class HistoryModel {
  HistoryModel({
    this.data,
  });

  Data data;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        data: Data.fromJson(json["launchesPast"]),
      );
}

class Data {
  Data({
    this.launchesPast,
  });

  List<LaunchesPast> launchesPast;

  factory Data.fromJson(List<dynamic> json) => Data(
        launchesPast: json.map((e) => LaunchesPast.fromJson(e)).toList(),
      );
}

class LaunchesPast {
  LaunchesPast({
    this.missionName,
    this.launchDateUtc,
    this.rocket,
    this.links,
  });

  String missionName;
  DateTime launchDateUtc;
  Rocket rocket;
  Links links;

  factory LaunchesPast.fromJson(Map<String, dynamic> json) => LaunchesPast(
        missionName: json["mission_name"],
        launchDateUtc: DateTime.parse(json["launch_date_utc"]),
        rocket: Rocket.fromJson(json["rocket"]),
        links: Links.fromJson(json["links"]),
      );
}

class Links {
  Links({
    this.articleLink,
    this.flickrImages,
  });

  String articleLink;
  List<String> flickrImages;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        articleLink: json["article_link"] == null ? null : json["article_link"],
        flickrImages: List<String>.from(json["flickr_images"].map((x) => x)),
      );
}

class Rocket {
  Rocket({
    this.rocketName,
    this.rocketType,
  });

  String rocketName;
  String rocketType;

  factory Rocket.fromJson(Map<String, dynamic> json) => Rocket(
        rocketName: json["rocket_name"],
        rocketType: json["rocket_type"],
      );
}
