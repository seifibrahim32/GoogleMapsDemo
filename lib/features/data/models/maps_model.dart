class MapsModel {
  String? nextPageToken;
  List<Results>? results;
  String? status;

  MapsModel(
      {required this.nextPageToken,
      required this.results,
      required this.status});

  MapsModel.fromJson(Map<String, dynamic> json) {
    nextPageToken = json['next_page_token'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_token'] = this.nextPageToken;
    final results = this.results;
    if (results != null) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Results {
  String? businessStatus;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photos>? photos;
  String? placeId;
  PlusCode? plusCode;
  int? priceLevel;
  num? rating;
  String? reference;
  late String scope;
  List<String>? types;
  int? userRatingsTotal;
  String? vicinity;
  OpeningHours? openingHours;
  bool? permanentlyClosed;

  Results(
      {required this.businessStatus,
      required this.geometry,
      required this.icon,
      required this.iconBackgroundColor,
      required this.iconMaskBaseUri,
      required this.name,
      required this.photos,
      required this.placeId,
      required this.plusCode,
      required this.priceLevel,
      required this.rating,
      required this.reference,
      required this.scope,
      required this.types,
      required this.userRatingsTotal,
      required this.vicinity,
      required this.openingHours,
      required this.permanentlyClosed});

  Results.fromJson(Map<String, dynamic> json) {
    businessStatus = json['business_status'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos?.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    priceLevel = json['price_level'];
    rating = json['rating'];
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'];
    vicinity = json['vicinity'];
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    permanentlyClosed = json['permanently_closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_status'] = this.businessStatus;
    final geometry = this.geometry;
    if (geometry != null) {
      data['geometry'] = geometry.toJson();
    }
    data['icon'] = icon;
    data['icon_background_color'] = this.iconBackgroundColor;
    data['icon_mask_base_uri'] = this.iconMaskBaseUri;
    data['name'] = this.name;
    if (photos != null) {
      data['photos'] = this.photos?.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    final plusCode = this.plusCode;
    if (plusCode != null) {
      data['plus_code'] = plusCode.toJson();
    }
    data['price_level'] = this.priceLevel;
    data['rating'] = this.rating;
    data['reference'] = this.reference;
    data['scope'] = this.scope;
    data['types'] = this.types;
    data['user_ratings_total'] = this.userRatingsTotal;
    data['vicinity'] = this.vicinity;
    final openingHours = this.openingHours;
    if (openingHours != null) {
      data['opening_hours'] = openingHours.toJson();
    }
    data['permanently_closed'] = this.permanentlyClosed;
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport =
        json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final location = this.location;
    if (location != null) {
      data['location'] = location.toJson();
    }
    final viewport = this.viewport;
    if (viewport != null) {
      data['viewport'] = viewport.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast =
        json['northeast'] != null ? Location.fromJson(json['northeast']) : null;
    southwest =
        json['southwest'] != null ? Location.fromJson(json['southwest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final northeast = this.northeast;
    if (northeast != null) {
      data['northeast'] = northeast.toJson();
    }
    final southwest = this.southwest;
    if (southwest != null) {
      data['southwest'] = southwest.toJson();
    }
    return data;
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}

class PlusCode {
  late String compoundCode;
  late String globalCode;

  PlusCode({required this.compoundCode,required this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

class OpeningHours {
  bool? openNow;

  OpeningHours({this.openNow});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open_now'] = this.openNow;
    return data;
  }
}
