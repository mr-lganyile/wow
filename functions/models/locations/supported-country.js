/* eslint-disable*/
class SupportedCountry {

    constructor(countryCode, countryName, countryNo) {
        this.countryCode = countryCode;
        this.countryName = countryName;
        this.countryNo = countryNo;
    }

    toJson() {
        return {
            countryCode: this.countryCode,
            countryName: this.countryName,
            countryNo: this.countryNo,
        };
    }
}

export default SupportedCountry