/// id : 1850
/// results : [{"iso_639_1":"en","iso_3166_1":"US","name":"Man on the Moon (1999) Original Trailer [FHD]","key":"cvaHj0np8GM","site":"YouTube","size":1080,"type":"Trailer","official":false,"published_at":"2022-11-02T12:30:12.000Z","id":"63669330d8d329007a500c7a"}]

class TrailerResponse {
  TrailerResponse({
    this.id,
    this.statusCode,
    this.statusMessage,
    this.success,
    this.results,
  });

  TrailerResponse.fromJson(dynamic json) {
    id = json['id'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Video.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    success = json['success'];
  }

  int? id;
  List<Video>? results;
  int? statusCode;
  String? statusMessage;
  String? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// iso_639_1 : "en"
/// iso_3166_1 : "US"
/// name : "Man on the Moon (1999) Original Trailer [FHD]"
/// key : "cvaHj0np8GM"
/// site : "YouTube"
/// size : 1080
/// type : "Trailer"
/// official : false
/// published_at : "2022-11-02T12:30:12.000Z"
/// id : "63669330d8d329007a500c7a"

class Video {
  Video({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  Video.fromJson(dynamic json) {
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    key = json['key'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    official = json['official'];
    publishedAt = json['published_at'];
    id = json['id'];
  }

  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_639_1'] = iso6391;
    map['iso_3166_1'] = iso31661;
    map['name'] = name;
    map['key'] = key;
    map['site'] = site;
    map['size'] = size;
    map['type'] = type;
    map['official'] = official;
    map['published_at'] = publishedAt;
    map['id'] = id;
    return map;
  }
}
