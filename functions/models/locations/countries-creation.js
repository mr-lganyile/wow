/* eslint-disable*/
import SupportedCountry from './supported-country.js'
import LocationCreation from './location-creation.js';
import LocationController from '../../controllers/location-controller.js';

class CountriesCreation extends LocationCreation {
    constructor() {
        super();
        this.locationController = new LocationController();

    }

    async createSupportedCountries() {

        const southAfrica = new SupportedCountry("ZA", "South Africa", "1");

        await this.locationController.createSupportedCountry(southAfrica.toJson());

    };
}

export default CountriesCreation