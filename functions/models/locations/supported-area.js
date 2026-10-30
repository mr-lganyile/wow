/* eslint-disable*/
class SupportedArea {

    constructor(townOrInstitutionFK, areaName, areaNo) {
        this.townOrInstitutionFK = townOrInstitutionFK;
        this.areaName = areaName;
        this.areaNo = areaNo;
    }

    toJson() {
        return {
            townOrInstitutionFK: this.townOrInstitutionFK,
            areaName: this.areaName,
            areaNo: this.areaNo,
        };
    }
}

export default SupportedArea