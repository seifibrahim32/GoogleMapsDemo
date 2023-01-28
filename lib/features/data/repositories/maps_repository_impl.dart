class Results {
  String? businessStatus;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  String? placeId;
  PlusCode? plusCode;
  String? reference;
  String? scope;
  List<String>? types;
  String? vicinity;

  Results(
      {required this.businessStatus,
      required this.geometry,
      required this.icon,
      required this.iconBackgroundColor,
      required this.iconMaskBaseUri,
      required this.name,
      required this.placeId,
      required this.plusCode,
      required this.reference,
      required this.scope,
      required this.types,
      required this.vicinity});

  Results.fromJson(Map<String, dynamic> json) {
    businessStatus = json['business_status'];
    geometry = (json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null)!;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    placeId = json['place_id'];
    plusCode = (json['plus_code'] != null
        ? PlusCode.fromJson(json['plus_code'])
        : null);
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_status'] = this.businessStatus;
    final geometry = this.geometry;
    if (geometry != null) {
      data['geometry'] = geometry.toJson();
    }
    data['icon'] = this.icon;
    data['icon_background_color'] = this.iconBackgroundColor;
    data['icon_mask_base_uri'] = this.iconMaskBaseUri;
    data['name'] = this.name;
    data['place_id'] = this.placeId;
    final plusCode = this.plusCode;
    if (plusCode != null) {
      data['plus_code'] = plusCode.toJson();
    }
    data['reference'] = this.reference;
    data['scope'] = this.scope;
    data['types'] = this.types;
    data['vicinity'] = this.vicinity;
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({required this.location, required this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = (json['location'] != null
        ? new Location.fromJson(json['location'])
        : null)!;
    viewport = (json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null)!;
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
  double? lat = 0.0;
  double? lng = 0.0;

  Location({required this.lat, required this.lng});

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

  Viewport({required this.northeast, required this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = (json['northeast'] != null
        ? new Location.fromJson(json['northeast'])
        : null)!;
    southwest = (json['southwest'] != null
        ? Location.fromJson(json['southwest'])
        : null)!;
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

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({required this.compoundCode, required this.globalCode});

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
