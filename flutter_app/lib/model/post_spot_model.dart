enum SeasonEnum {
  spring,
  summer,
  autumn,
  winter,
}

enum HistoryEnum {
  recent,
  littleOld,
  old,
}

enum TimeEnum {
  daytime,
  sunset,
  night,
}

class PostSpotRequest {
  late double lat;
  double lng = 139.7673068;
  late SeasonEnum season;
  late HistoryEnum history;
  late TimeEnum time;
  late String userId;
  late String name;

  PostSpotRequest({
    this.lat = 35.6809591,
    this.lng = 139.7673068,
    required this.name,
    required this.season,
    required this.history,
    required this.time,
    required this.userId,
  });

  Map<String,dynamic> convert2map() {
    return {
      "latitude": lat,
      "longitude": lng,
      "season": season.index,
      "history": history.index,
      "time": time.index,
      "userId": userId,
      "name": name,
    };
  }
}