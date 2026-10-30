/* eslint-disable*/
import LocationCreation from './location-creation.js';
import SupportedProvinceOrState from './supported-province-or-state.js';
import LocationController from '../../controllers/location-controller.js';

class ProvinciesOrStatesCreation extends LocationCreation {
    constructor() {
        super();
        this.locationController = new LocationController();
    }

    async createSupportedProvincesOrStates() {
        const kzn = new SupportedProvinceOrState("ZA", "Kwa Zulu Natal", "1",);
        await this.locationController.createSupportedProvincesOrStates(kzn.toJson());
    };

}

export default ProvinciesOrStatesCreation