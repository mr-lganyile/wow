/* eslint-disable*/
import LocationCreation from './location-creation.js';
import SupportedArea from "./supported-area.js";
import LocationController from '../../controllers/location-controller.js';

// Last area number is 94 (PMB UKZN).
class AreasCreation extends LocationCreation {

    constructor() {
        super();
        this.locationController = new LocationController();
    }

    // Town/Institution 4
    async createUKZNSupportedAreas() {

        const howard = new SupportedArea("4",
            "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa", "30");
        await this.locationController.createSupportedArea(howard.toJson())
    };


    // Town/Institution 7
    async createDurbanCentralSupportedAreas() {
        const glenwood = new SupportedArea("7",
            "Glenwood-Durban Central-Durban-Kwa Zulu Natal-South Africa", "43");
        await this.locationController.createSupportedArea(glenwood.toJson());
        const berea = new SupportedArea("7",
            "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa", "44");
        await this.locationController.createSupportedArea(berea.toJson());
        const southBeach = new SupportedArea("7",
            "South Beach-Durban Central-Durban-Kwa Zulu Natal-South Africa", "45");
        await this.locationController.createSupportedArea(southBeach.toJson());
        const masgrave = new SupportedArea("7",
            "Masgrave-Durban Central-Durban-Kwa Zulu Natal-South Africa", "46");
        await this.locationController.createSupportedArea(masgrave.toJson());
    };

    async createSupportedAreas() {

        await this.createUKZNSupportedAreas();
        await this.createDurbanCentralSupportedAreas();

    };

}

export default AreasCreation