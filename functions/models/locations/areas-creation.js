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

    // Town/Institution 1
    async createUmlaziSupportedAreas() {
        const aSection = new SupportedArea("1",
            "A Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "1");
        await this.locationController.createSupportedArea(aSection.toJson());
        const aaSection = new SupportedArea("1",
            "AA Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "2");
        await this.locationController.createSupportedArea(aaSection.toJson());
        const bSection = new SupportedArea("1",
            "B Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "3");
        await this.locationController.createSupportedArea(bSection.toJson());
        const bbSection = new SupportedArea("1",
            "BB Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "4");
        await this.locationController.createSupportedArea(bbSection.toJson());
        const cSection = new SupportedArea("1",
            "C Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "5");
        await this.locationController.createSupportedArea(cSection.toJson());
        const ccSection = new SupportedArea("1",
            "CC Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "6");
        await this.locationController.createSupportedArea(ccSection.toJson());
        const dSection = new SupportedArea("1",
            "D Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "7");
        await this.locationController.createSupportedArea(dSection.toJson());
        const eSection = new SupportedArea("1",
            "E Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "8");
        await this.locationController.createSupportedArea(eSection.toJson());
        const fSection = new SupportedArea("1",
            "F Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "9");
        await this.locationController.createSupportedArea(fSection.toJson());
        const gSection = new SupportedArea("1",
            "G Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "10");
        await this.locationController.createSupportedArea(gSection.toJson());
        const hSection = new SupportedArea("1",
            "H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "11");
        await this.locationController.createSupportedArea(hSection.toJson());
        const jSection = new SupportedArea("1",
            "J Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "12");
        await this.locationController.createSupportedArea(jSection.toJson());
        const kSection = new SupportedArea("1",
            "K Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "13");
        await this.locationController.createSupportedArea(kSection.toJson());
        const lSection = new SupportedArea("1",
            "L Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "14");
        await this.locationController.createSupportedArea(lSection.toJson());
        const mSection = new SupportedArea("1",
            "M Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "15");
        await this.locationController.createSupportedArea(mSection.toJson());
        const nSection = new SupportedArea("1",
            "N Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "16");
        await this.locationController.createSupportedArea(nSection.toJson());
        const pSection = new SupportedArea("1",
            "P Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "17");
        await this.locationController.createSupportedArea(pSection.toJson());
        const qSection = new SupportedArea("1",
            "Q Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "18");
        await this.locationController.createSupportedArea(qSection.toJson());
        const rSection = new SupportedArea("1",
            "R Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "19");
        await this.locationController.createSupportedArea(rSection.toJson());
        const sSection = new SupportedArea("1",
            "S Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "20");
        await this.locationController.createSupportedArea(sSection.toJson());
        const uSection = new SupportedArea("1",
            "U Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "21");
        await this.locationController.createSupportedArea(uSection.toJson());
        const vSection = new SupportedArea("1",
            "V Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "22");
        await this.locationController.createSupportedArea(vSection.toJson());
        const wSection = new SupportedArea("1",
            "W Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "23");
        await this.locationController.createSupportedArea(wSection.toJson());
        const malukazi = new SupportedArea("1",
            "Malukazi-Umlazi-Durban-Kwa Zulu Natal-South Africa", "24");
        await this.locationController.createSupportedArea(malukazi.toJson());
        const philani = new SupportedArea("1",
            "Philani-Umlazi-Durban-Kwa Zulu Natal-South Africa", "25");
        await this.locationController.createSupportedArea(philani.toJson());
        const ySection = new SupportedArea("1",
            "Y Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "26");
        await this.locationController.createSupportedArea(ySection.toJson());
        const zSection = new SupportedArea("1",
            "Z Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "27");
        await this.locationController.createSupportedArea(zSection.toJson());

    };

    // Town/Institution 4
    async createUKZNSupportedAreas() {

        const howard = new SupportedArea("4",
            "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa", "30");
        await this.locationController.createSupportedArea(howard.toJson())
    };

    // Town/Institution 5
    async createMayvilleSupportedAreas() {


        const catoCrest = new SupportedArea("5",
            "Cato Crest-Mayville-Durban-Kwa Zulu Natal-South Africa", "31");
        await this.locationController.createSupportedArea(catoCrest.toJson());
        const catoManor = new SupportedArea("5",
            "Cato Manor-Mayville-Durban-Kwa Zulu Natal-South Africa", "32");
        await this.locationController.createSupportedArea(catoManor.toJson());
        const richView = new SupportedArea("5",
            "Richview-Mayville-Durban-Kwa Zulu Natal-South Africa", "33");
        await this.locationController.createSupportedArea(richView.toJson());
        const masxha = new SupportedArea("5",
            "Masxha-Mayville-Durban-Kwa Zulu Natal-South Africa", "34");
        await this.locationController.createSupportedArea(masxha.toJson());
        const bonela = new SupportedArea("5",
            "Bonela-Mayville-Durban-Kwa Zulu Natal-South Africa", "35");
        await this.locationController.createSupportedArea(bonela.toJson());
        const nsimbini = new SupportedArea("5",
            "Nsimbini-Mayville-Durban-Kwa Zulu Natal-South Africa", "36");
        await this.locationController.createSupportedArea(nsimbini.toJson());
        const galway = new SupportedArea("5",
            "Galway-Mayville-Durban-Kwa Zulu Natal-South Africa", "89");
        await this.locationController.createSupportedArea(galway.toJson());
        const nkanini = new SupportedArea("5",
            "Nkanini-Mayville-Durban-Kwa Zulu Natal-South Africa", "90");
        await this.locationController.createSupportedArea(nkanini.toJson());
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

        // await this.createUmlaziSupportedAreas();
        // await this.createUKZNSupportedAreas();
        await this.createMayvilleSupportedAreas();
        await this.createDurbanCentralSupportedAreas();

    };

}

export default AreasCreation