/* eslint-disable*/
import { getFirestore, Timestamp } from "firebase-admin/firestore";

class LocationController {

    constructor() {
        this.supportedCountriesCollection =
            getFirestore().collection("supported_countries");
        this.supportedProvincesOrStatesCollection =
            getFirestore().collection("supported_provinces_or_states");
        this.supportedCitiesCollection =
            getFirestore().collection("supported_cities");
        this.supportedTownsOrInstitutionsCollection =
            getFirestore().collection("supported_towns_or_institutions");
        this.supportedAreasCollection =
            getFirestore().collection("supported_areas");
    };

    async createSupportedCountry(country) {
        await this.supportedCountriesCollection.doc(country.countryCode).set(country);
    }

    async createSupportedProvincesOrStates(province) {
        await this.supportedProvincesOrStatesCollection
            .doc(province.provinceOrStateNo).set(province);
    };

    async createSupportedCity(city) {
        await this.supportedCitiesCollection
            .doc(city.cityNo).set(city);
    };

    async createSupportedTownsOrInstitution(townOrInstitution) {
        await this.supportedTownsOrInstitutionsCollection
            .doc(townOrInstitution.townOrInstitutionNo).set(townOrInstitution);
    }

    async createSupportedArea(area) {
        await this.supportedAreasCollection
            .doc(area.areaNo).set(area);

    }
}

export default LocationController