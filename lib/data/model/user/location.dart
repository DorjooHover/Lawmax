class LocationDto {
  double? lat;
  double? lng;

  LocationDto({this.lat, this.lng});

  LocationDto.fromJson(Map<String, dynamic> json) {
    lat = double.parse(json['lat'].toString());
    lng = double.parse(json['lng'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
