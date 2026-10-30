/* eslint-disable*/
import { getFirestore } from "firebase-admin/firestore";

class FakeUsers {
    constructor() {
    }

    // Umlazi
    async createFakeUmlaziUsers(online) {

        const umlaziUserNames = [
            "1lNH8McSzqrdJ8hlEnRgXQkslrdr",
        ];

        let reference = getFirestore().collection("users").doc(umlaziUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "umlazi/users/profile_images/+27680000000.jpg",
            phoneNumber: "+27680000000",
            area: {
                townOrInstitutionFK: "1",
                areaName: "H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "11",
            },
            username: "Msayi",
            password: "mrm",
        };
        await reference.set(alcoholic);
    }

    // MUT
    async createFakeMUTUsers(online) {

        const mutUserNames = [
            "1lNH8McSzqrdJ8hlEnRgXQkslrdr",
        ];

        let reference = getFirestore().collection("users").doc(mutUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "mangosuthu (mut)/users/profile_images/+27690000000.jpg",
            phoneNumber: "+27690000000",
            area: {
                townOrInstitutionFK: "2",
                areaName: "Mangosuthu (MUT)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "28",
            },
            username: "Amanda",
            password: "mrm",
        };
        await reference.set(alcoholic);
    }

    // DUT
    async createFakeDUTUsers(online) {

        // DUT 1
        const dutUserNames = [
            // Users below are authenticated.
            // online ? "16ozm44uT7PbezHF7vhmtOeqa953" : "klNH8McSzqrdJ8hlEnRgXQkslpJF",
            "1lNH8McSzqrdJ8hlEnRgXQkslpJF",
            "2lNH8McSzqrdJ8hlEnRgXQkslpJF",
            "3lNH8McSzqrdJ8hlEnRgXQkslpJF",
            "4lNH8McSzqrdJ8hlEnRgXQkslpJF",
            "5lNH8McSzqrdJ8hlEnRgXQkslpJF",
        ];
        let reference = getFirestore().collection("users").doc(dutUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "dut/users/profile_images/+27698765432.jpg",
            phoneNumber: "+27698765432",
            area: {
                townOrInstitutionFK: "3",
                areaName: "DUT-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "29",
            },
            username: "Nelly",
            password: "mrm",
        };
        await reference.set(alcoholic);

        // DUT 2
        reference = getFirestore().collection("users").doc(dutUserNames[1]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "dut/users/profile_images/+276887654321.jpg",
            phoneNumber: "+276887654321",
            area: {
                townOrInstitutionFK: "3",
                areaName: "DUT-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "29",
            },
            username: "Sne",
            password: "ytcc",
        };
        await reference.set(alcoholic);

        // DUT 3
        reference = getFirestore().collection("users").doc(dutUserNames[2]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "dut/users/profile_images/+27676543210.jpg",
            phoneNumber: "+27676543210",
            area: {
                townOrInstitutionFK: "3",
                areaName: "DUT-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "29",
            },
            username: "Zama",
            password: "zamaa",
        };
        await reference.set(alcoholic);

        // DUT 4
        reference = getFirestore().collection("users").doc(dutUserNames[3]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "dut/users/profile_images/+27665432109.jpg",
            phoneNumber: "+27665432109",
            area: {
                townOrInstitutionFK: "3",
                areaName: "DUT-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "29",
            },
            username: "Bonga",
            password: "kouk",
        };
        await reference.set(alcoholic);

        // DUT 5
        reference = getFirestore().collection("users").doc(dutUserNames[3]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "dut/users/profile_images/+27654321098.jpg",
            phoneNumber: "+27654321098",
            area: {
                townOrInstitutionFK: "3",
                areaName: "DUT-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "29",
            },
            username: "Kelly",
            password: "kkk",
        };
        await reference.set(alcoholic);

    }

    // UKZN
    async createFakeUKZNUsers(online) {


        const ukznUserNames = [
            // Users below are authenticated.
            // online ? "tTYYb0n5qUavhmENSrP9SytKt1V2" : "sHs3EWiJjPINmkj50051ij2dyLkN",
            "aHs3EWiJjPINmkj50051ij2dyLkN",
            "bHs3EWiJjPINmkj50051ij2dyLkN",
            "cHs3EWiJjPINmkj50051ij2dyLkN",
            "dHs3EWiJjPINmkj50051ij2dyLkN",
            "eHs3EWiJjPINmkj50051ij2dyLkN"
        ];
        let reference = getFirestore().collection("users").doc(ukznUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "howard college (ukzn)/users/profile_images/+2761111111111.jpg",
            phoneNumber: "+2761111111111",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Thabiso",
            password: "kwl-guy1",
        };
        await reference.set(alcoholic);

        reference = getFirestore().collection("users").doc(ukznUserNames[1]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "howard college (ukzn)/users/profile_images/+27622222222.jpg",
            phoneNumber: "+27622222222",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Ayanda",
            password: "kwl-guy2",
        };
        await reference.set(alcoholic);

        reference = getFirestore().collection("users").doc(ukznUserNames[2]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "howard college (ukzn)/users/profile_images/+27633333333.jpg",
            phoneNumber: "+27633333333",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Tasha",
            password: "kwl-girl",
        };
        await reference.set(alcoholic);

        reference = getFirestore().collection("users").doc(ukznUserNames[3]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "howard college (ukzn)/users/profile_images/+27644444444.jpg",
            phoneNumber: "+27644444444",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Tman",
            password: "kwl-guy3",
        };
        await reference.set(alcoholic);

        reference = getFirestore().collection("users").doc(ukznUserNames[4]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "howard college (ukzn)/users/profile_images/+27655555555.jpg",
            phoneNumber: "+27655555555",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Dude4Girls",
            password: "kwl-guy4",
        };
        await reference.set(alcoholic);


    }

    // Mayville
    async createFakeMayvilleUsers(online) {


        const mayvilleUserNames = [
            // Users below are authenticated.
            "o0m4D3ggJdJeGKDfOAmHg6zVdjn1",
            "Aeg7RVmhnOOSmoMpn8kuZfrRfgIi"
        ];
        let reference = getFirestore().collection("users").doc(mayvilleUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "mayville/users/profile_images/+27712345678.jpg",
            phoneNumber: "+27712345678",
            area: {
                townOrInstitutionFK: "5",
                areaName: "Cato Crest-Mayville-Durban-Kwa Zulu Natal-South ",
                areaNo: "31",
            },
            username: "Sakhile",
            password: "12abc12",
        };
        await reference.set(alcoholic);

        reference = getFirestore().collection("users").doc(mayvilleUserNames[1]);
        alcoholic = {
            userId: reference.id,
            profileImageURL: "mayville/users/profile_images/+27612345678.jpg",
            phoneNumber: "+27612345678",
            area: {
                townOrInstitutionFK: "5",
                areaName: "Cato Crest-Mayville-Durban-Kwa Zulu Natal-South ",
                areaNo: "31",
            },
            username: "Simo",
            password: "Simza",
        };
        await reference.set(alcoholic);
    }

    // Sydenham
    async createFakeSydenhamUsers(online) {


        const sydenhamUserNames = [
            // Users below are authenticated.
            // online ? "D8CBB1DjVHZXpFCcDTYTjldIVDX2" : "Wc5RNHS67csxXBECaJ2esblYdQ9k",
            "1c5RNHS67csxXBECaJ2esblYdQ9k",

        ];
        let reference = getFirestore().collection("users").doc(sydenhamUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "sydenham/users/profile_images/+27634567890.jpg",
            phoneNumber: "+27634567890",
            area: {
                townOrInstitutionFK: "6",
                areaName: "Foreman-Sydenham-Durban-Kwa Zulu Natal-South ",
                areaNo: "37",
            },
            username: "Luyolo",
            password: "12abc12",
        };
        await reference.set(alcoholic);


    }

    // Durban Central
    async createFakeDurbanCentralUsers(online) {


        const durbanCentralUserNames = [
            // Users below are authenticated.
            online ? "WurvL7g6IgXVHYuMbfq4UnueVNQ2" : "3L1BNU0ptl9tUOuT3FOFduz8bmXo"
        ];


        let reference = getFirestore().collection("users").doc(durbanCentralUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "durban central/users/profile_images/+27767890123.jpg",
            phoneNumber: "+27767890123",
            area: {
                townOrInstitutionFK: "7",
                areaName: "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "44",
            },
            username: "Andy",
            password: "cii0",
        };
        await reference.set(alcoholic);
    }

    // Nanda
    async createFakeNandaUsers(online) {


        const nandaUserNames = [
            // Users below are authenticated.
            online ? "WurvL7g6IgXVHurmbfq4UnueVNQ2" : "3L1BNU0ptl9tUOuT3FOokjz8bmXo"
        ];


        let reference = getFirestore().collection("users").doc(nandaUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "durban central/users/profile_images/+27811111111.jpg",
            phoneNumber: "+27811111111",
            area: {
                townOrInstitutionFK: "8",
                areaName: "Africa-Nanda-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "53",
            },
            username: "Sceloz",
            password: "cioiu",
        };
        await reference.set(alcoholic);
    }

    // Hamarsdale
    async createFakeHamarsdaleUsers(online) {


        const hammarsdaleUserNames = [
            // Users below are authenticated.
            online ? "WurvL7g6IgXVHurmbfq4UvveVNQ2" : "3L1BNUlltl9tUOuT3FOokjz8bmXo"
        ];


        let reference = getFirestore().collection("users").doc(hammarsdaleUserNames[0]);
        let alcoholic = {
            userId: reference.id,
            profileImageURL: "hamarsdale/users/profile_images/+27711111111.jpg",
            phoneNumber: "+27711111111",
            area: {
                townOrInstitutionFK: "9",
                areaName: "Unit 2 North-Hammarsdale-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "74",
            },
            username: "Mthibos",
            password: "ciodnh",
        };
        await reference.set(alcoholic);
    }

    async createFakeUsers(online) {
        await this.createFakeUmlaziUsers(online);
        await this.createFakeDUTUsers(online);
        await this.createFakeUKZNUsers(online);
        await this.createFakeMayvilleUsers(online);
        await this.createFakeSydenhamUsers(online);
        await this.createFakeSydenhamUsers(online);
        await this.createFakeDurbanCentralUsers(online);
        await this.createFakeNandaUsers(online);
        await this.createFakeHamarsdaleUsers(online);
    }
}

export default FakeUsers