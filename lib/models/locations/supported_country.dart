// Collection Name /supported_countries/{supportedCountryId}
// Branch : supported_locations_resources_crud ->  create_supported_locations_front_end
class SupportedCountry {
  String countryNo;
  String countryName;
  String countryCode;
  SupportedCountry({
    required this.countryNo,
    required this.countryName,
    required this.countryCode,
  });

  factory SupportedCountry.fromJson(dynamic json) => SupportedCountry(
        countryNo: json['countryNo'],
        countryName: json['countryName'],
        countryCode: json['countryCode'],
      );

  @override
  String toString() {
    return countryName;
  }
}
