/* eslint-disable*/
class SupportedProvinceOrState {

    constructor(countryFK, provinceOrStateName, provinceOrStateNo) {
        this.countryFK = countryFK;
        this.provinceOrStateName = provinceOrStateName;
        this.provinceOrStateNo = provinceOrStateNo;
    }

    toJson() {
        return {
            countryFK: this.countryFK,
            provinceOrStateName: this.provinceOrStateName,
            provinceOrStateNo: this.provinceOrStateNo,
        };
    }
}

export default SupportedProvinceOrState