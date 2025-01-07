class PlaceSearch {
  final String description;
  final String placeId;
  final String name;

  PlaceSearch({
    this.description = "",
    this.placeId = "",
    this.name = "",
  });

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
      description: json['description'],
      placeId: json['place_id'],
      name: json['structured_formatting']["main_text"],
    );
  }

  static List<PlaceSearch> jsonToAutoCompleteList(List<dynamic> emote) =>
      emote.map<PlaceSearch>((item) => PlaceSearch.fromJson(item)).toList();
}

class PlaceModel {
  // final GeometryModel geometry;
  final dynamic rating;
  final dynamic lat;
  final dynamic lng;
  final String formatted_address;

  PlaceModel({
    this.rating = 0.0,
    this.lat = 0.0,
    this.lng = 0.0,
    this.formatted_address = "",
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      rating: json['rating'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      formatted_address: json['formatted_address'],
    );
  }

  factory PlaceModel.fromEmpty() {
    return PlaceModel(
      rating: 0.0,
      lat: 0.0,
      lng: 0.0,
    );
  }
}

class NearBySearch {
  final String description;
  final String placeId;
  final String name;
  List<PhotoReference> photo_reference;
  dynamic rating;
  dynamic lat;
  dynamic lng;

  NearBySearch({
    this.description = "",
    this.placeId = "",
    this.name = "",
    required this.photo_reference,
    this.rating = 0.0,
    this.lat = 0.0,
    this.lng = 0.0,
  });

  factory NearBySearch.fromJson(Map<String, dynamic> json) {
    return NearBySearch(
      description: json['vicinity'] ?? "No Address",
      placeId: json['place_id'],
      name: json["name"],
      photo_reference: json["photos"] != null
          ? PhotoReference.jsonToPhotoReferenceList(json["photos"])
          : [],
      rating: json['rating'] ?? 0.0,
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
    );
  }

  static List<NearBySearch> jsonToNearBySearchList(List<dynamic> emote) =>
      emote.map<NearBySearch>((item) => NearBySearch.fromJson(item)).toList();
}

class PhotoReference {
  final String photoID;

  PhotoReference({
    this.photoID = "",
  });

  factory PhotoReference.fromJson(Map<String, dynamic> json) {
    return PhotoReference(
      photoID: json["photo_reference"],
    );
  }

  static List<PhotoReference> jsonToPhotoReferenceList(List<dynamic> emote) =>
      emote
          .map<PhotoReference>((item) => PhotoReference.fromJson(item))
          .toList();
}
