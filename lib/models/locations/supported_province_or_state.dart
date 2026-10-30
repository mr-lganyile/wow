// Collection Name /provinces_or_states/{provinceOrStateId}
// Branch : supported_locations_resources_crud ->  create_supported_locations_front_end
class SupportedProvinceOrState {
  String provinceOrStateNo;
  String provinceOrStateName;
  String countryFK;

  SupportedProvinceOrState({
    required this.provinceOrStateNo,
    required this.provinceOrStateName,
    required this.countryFK,
  });

  factory SupportedProvinceOrState.fromJson(dynamic json) =>
      SupportedProvinceOrState(
        provinceOrStateNo: json['provinceOrStateNo'],
        provinceOrStateName: json['provinceOrStateName'],
        countryFK: json['countryFK'],
      );

  @override
  String toString() {
    return provinceOrStateName;
  }
}
