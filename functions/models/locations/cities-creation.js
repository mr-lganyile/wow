/* eslint-disable*/
import LocationCreation from './location-creation.js';
import SupportedCity from './supported-city.js';
import LocationController from '../../controllers/location-controller.js';

class CitiesCreation extends LocationCreation {

    constructor() {
        super();
        this.locationController = new LocationController();
    }

    async createSupportedCities() {

        const durban = new SupportedCity("1", "Durban", "1",);
        await this.locationController.createSupportedCity(durban.toJson())

        const pinetown = new SupportedCity("1", "Pinetown", "2",);
        await this.locationController.createSupportedCity(pinetown.toJson())

        const pietermaritzburg = new SupportedCity("1", "Pietermaritzburg", "3",);
        await this.locationController.createSupportedCity(pietermaritzburg.toJson())
    }
}

export default CitiesCreation