/* eslint-disable*/
import LocationCreation from './location-creation.js';
import SupportedTownOrInstitution from './supported-town-or-institution.js';
import LocationController from '../../controllers/location-controller.js';

class TownsOrInstitutionsCreation extends LocationCreation {
    constructor() {
        super();
        this.locationController = new LocationController();
    }

    async createSupportedTownsOrInstitutions() {

        const durbanCentral = new SupportedTownOrInstitution("1", "Durban Central", "7");
        await this.locationController.createSupportedTownsOrInstitution(durbanCentral.toJson());

        const mayville = new SupportedTownOrInstitution("1", "Mayville", "5");
        await this.locationController.createSupportedTownsOrInstitution(mayville.toJson());

    }
}

export default TownsOrInstitutionsCreation