import 'dart:convert';

import 'package:http/http.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  WorldTime({
    this.location,
    this.time,
    this.flag,
    this.url,
  });

  WorldTime copyWith({
    String location,
    String time,
    String flag,
    String url,
  }) {
    return WorldTime(
      location: location ?? this.location,
      time: time ?? this.time,
      flag: flag ?? this.flag,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'time': time,
      'flag': flag,
      'url': url,
    };
  }

  factory WorldTime.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WorldTime(
      location: map['location'],
      time: map['time'],
      flag: map['flag'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WorldTime.fromJson(String source) =>
      WorldTime.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WorldTime(location: $location, time: $time, flag: $flag, url: $url)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WorldTime &&
        o.location == location &&
        o.time == time &&
        o.flag == flag &&
        o.url == url;
  }

  @override
  int get hashCode {
    return location.hashCode ^ time.hashCode ^ flag.hashCode ^ url.hashCode;
  }

  Future<void> getTime() async {
    try {
      // Make Request
      Response response =
          await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // Get Properties from data
      String datetime = data['datetime'];
      String offset_hour = data['utc_offset'].substring(1, 3);
      String offset_min = data['utc_offset'].substring(4, 6);
      // Datetime Object
      DateTime now = DateTime.parse(datetime);
      now = now.add(
        Duration(hours: int.parse(offset_hour), minutes: int.parse(offset_min)),
      );

      time = now.toString();
    } catch (e) {
      print('Caught Error : $e');
      time = 'Could not get time data';
    }
  }
}
