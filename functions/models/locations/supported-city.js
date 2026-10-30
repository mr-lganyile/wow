/* eslint-disable*/
class SupportedCity {

    constructor(provinceOrStateNo, cityName, cityNo) {
        this.provinceOrStateNo = provinceOrStateNo;
        this.cityName = cityName;
        this.cityNo = cityNo;
    }

    toJson() {
        return {
            provinceOrStateNo: this.provinceOrStateNo,
            cityName: this.cityName,
            cityNo: this.cityNo,
        };
    }
}

export default SupportedCity