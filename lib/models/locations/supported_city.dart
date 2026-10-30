// Collection Name /supported_cities/{supportedCityId}
// Branch : supported_locations_resources_crud ->  create_supported_locations_front_end

class SupportedCity {
  String cityNo;
  String provinceOrStateFK;
  String cityName;

  SupportedCity(
      {required this.cityNo,
      required this.provinceOrStateFK,
      required this.cityName});

  factory SupportedCity.fromJson(dynamic json) => SupportedCity(
      cityNo: json['cityNo'],
      provinceOrStateFK: json['provinceOrStateFK'],
      cityName: json['cityName']);

  @override
  String toString() {
    return cityName;
  }
}
