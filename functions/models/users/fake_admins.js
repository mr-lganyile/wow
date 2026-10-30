/* eslint-disable*/
import { getFirestore } from "firebase-admin/firestore";

class FakeAdmins {
    constructor() {

    }

    async createFakeAdmin(online) {
        let adminReference;

        const year = 2026;
        let month = 1 + Math.floor(Math.random() * 10);
        let day = 1 + Math.floor(Math.random() * 30);

        let admin;

        const adminsUserIds = [
            // Admins below are authenticated.
            // "Pkig7aqcajZgZDptqxbixvZbp122", // Prod +27611111111
            "wvhg7UvL9aOzJYY4s8mYoT5Rv4TX" // Emulator
        ];

        adminReference = getFirestore().collection("admins").doc(adminsUserIds[0]);

        // Superior Admin
        admin =
        {
            userId: adminReference.id,
            adminType: 'Both',
            isSuperior: true,
            key: "000",
            isFemale: false,
            townOrInstitution: "Mayville",
            phoneNumber: "+27611111111",
            profileImageURL: "/admins/profile_images/+27611111111.png",
            password: "qwerty321",
            isBlocked: false,
            joinedOn: {
                year: year,
                month: month,
                day: day,
            }
        };

        await adminReference.set(admin);

    }
}

export default FakeAdmins