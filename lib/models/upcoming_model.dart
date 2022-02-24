class UpComingModel {
  UpComingModel({
    this.data,
  });

  Data data;

  factory UpComingModel.fromJson(Map<String, dynamic> json) => UpComingModel(
        data: Data.fromJson(json["launchesUpcoming"]),
      );
}

class Data {
  Data({
    this.launchesUpcoming,
  });

  List<LaunchesUpcoming> launchesUpcoming;

  factory Data.fromJson(List<dynamic> json) => Data(
        launchesUpcoming:
            json.map((e) => LaunchesUpcoming.fromJson(e)).toList(),
      );
}

class LaunchesUpcoming {
  LaunchesUpcoming({
    this.id,
    this.missionName,
    this.launchDateUtc,
    this.rocket,
    this.links,
  });

  String id;
  String missionName;
  DateTime launchDateUtc;
  Rocket rocket;
  Links links;

  factory LaunchesUpcoming.fromJson(Map<String, dynamic> json) =>
      LaunchesUpcoming(
        id: json["id"],
        missionName: json["mission_name"],
        launchDateUtc: DateTime.parse(json["launch_date_utc"]),
        rocket: Rocket.fromJson(json["rocket"]),
        links: Links.fromJson(json["links"]),
      );
}

class Links {
  Links({
    this.flickrImages,
  });

  List<dynamic> flickrImages;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        flickrImages: List<dynamic>.from(json["flickr_images"].map((x) => x)),
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
