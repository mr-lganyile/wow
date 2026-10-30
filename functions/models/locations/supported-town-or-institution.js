/* eslint-disable*/
class SupportedTownOrInstitution {

    constructor(cityFK, townOrInstitutionName, townOrInstitutionNo) {
        this.cityFK = cityFK;
        this.townOrInstitutionName = townOrInstitutionName;
        this.townOrInstitutionNo = townOrInstitutionNo;
    }

    toJson() {
        return {
            cityFK: this.cityFK,
            townOrInstitutionName: this.townOrInstitutionName,
            townOrInstitutionNo: this.townOrInstitutionNo,
        };
    }
}

export default SupportedTownOrInstitution 