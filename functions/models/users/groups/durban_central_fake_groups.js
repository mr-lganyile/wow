/* eslint-disable*/
import { getFirestore } from "firebase-admin/firestore";

class DurbanCentralFakeGroups {
    constructor() {

    }

    // Images exist on emulator [Real Areas & Fake Members]
    async durbanCentralGroups() {
        const host = "durban central";
        const group1Members = ["+27600000000"];
        const group1CreatorPhoneNumber = "+27600000000";
        const group1Id = "dbn-central-fake-group-1";

        const group2Members = ["+27610000000", "+27610000001"];
        const group2CreatorPhoneNumber = "+27610000000";
        const group2Id = "dbn-central-fake-group-2";

        const group3Members = ["+27620000000", "+27620000001", "+27620000002"];
        const group3CreatorPhoneNumber = "+27620000000";
        const group3Id = "dbn-central-fake-group-3";

        const group4Members = ["+27630000000", "+27630000001", "+27630000002", "+27630000003", "+27630000004"];
        const group4CreatorPhoneNumber = "+27630000000";
        const group4Id = "dbn-central-fake-group-4";

        const group1Area = {
            townOrInstitutionFK: "7",
            areaName: "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "44",
        };
        const specificArea1 = 'Regency';

        const group2Area = {
            townOrInstitutionFK: "7",
            areaName: "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "44",
        };
        const specificArea2 = 'Cuban';

        const group3Area = {
            townOrInstitutionFK: "7",
            areaName: "Glenwood-Durban Central-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "43",
        };
        const specificArea3 = 'Lyndely';

        const group4Area = {
            townOrInstitutionFK: "7",
            areaName: "Masgrave-Durban Central-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "46",
        };
        const specificArea4 = 'Floredene';

        const groupTownOrInstitution = {
            cityFK: "1",
            townOrInstitutionName: "Durban Central",
            townOrInstitutionNo: "7",
        };

        const groupName1 = "Ass Kickers";
        const group1CreatorUsername = "Roney";

        const groupName2 = "Nice Guys";
        const group2CreatorUsername = "Thalente";

        const groupName3 = "High Rollers";
        const group3CreatorUsername = "Jacob";

        const groupName4 = "The Kings";
        const group4CreatorUsername = "Vincent";


        const group1 = {
            groupId: group1Id,
            groupName: groupName1,
            groupRegisteryAdminId: '4kVF6YK7Flc4nw31JQfDh0vZLFB2',
            groupImageURL: `/${host}/groups_specific_locations/${group1Id}.jpg`,
            groupArea: group1Area,
            groupSpecificArea: specificArea1,
            groupTownOrInstitution: groupTownOrInstitution,

            groupCreatorPhoneNumber: group1CreatorPhoneNumber,
            groupCreatorImageURL: `/${host}/group_members/${group1Id}/profile_images/${group1CreatorPhoneNumber}.webp`,
            groupCreatorUsername: group1CreatorUsername,
            isActive: true,
            maxNoOfMembers: 5, // 5

            groupMembers: group1Members,
            activationRequest: null,
        };

        const group2 = {
            groupId: group2Id,
            groupName: groupName2,
            groupRegisteryAdminId: '4kVF6YK7Flc4nw31JQfDh0vZLFB2',
            groupImageURL: `/${host}/groups_specific_locations/${group2Id}.jpg`,
            groupArea: group2Area,
            groupSpecificArea: specificArea2,
            groupTownOrInstitution: groupTownOrInstitution,

            groupCreatorPhoneNumber: group2CreatorPhoneNumber,
            groupCreatorImageURL: `/${host}/group_members/${group2Id}/profile_images/${group2CreatorPhoneNumber}.webp`,
            groupCreatorUsername: group2CreatorUsername,
            isActive: true,
            maxNoOfMembers: 5, // 5

            groupMembers: group2Members,
            activationRequest: null,
        };

        const group3 = {
            groupId: group3Id,
            groupName: groupName3,
            groupRegisteryAdminId: '4kVF6YK7Flc4nw31JQfDh0vZLFB2',
            groupImageURL: `/${host}/groups_specific_locations/${group3Id}.jpg`,
            groupArea: group3Area,
            groupSpecificArea: specificArea3,
            groupTownOrInstitution: groupTownOrInstitution,

            groupCreatorPhoneNumber: group3CreatorPhoneNumber,
            groupCreatorImageURL: `/${host}/group_members/${group3Id}/profile_images/${group3CreatorPhoneNumber}.webp`,
            groupCreatorUsername: group3CreatorUsername,
            isActive: true,
            maxNoOfMembers: 5, // 5

            groupMembers: group3Members,
            activationRequest: null,
        };

        const group4 = {
            groupId: group4Id,
            groupName: groupName4,
            groupRegisteryAdminId: null,
            groupImageURL: `/${host}/groups_specific_locations/${group4Id}.jpg`,
            groupArea: group4Area,
            groupSpecificArea: specificArea4,
            groupTownOrInstitution: groupTownOrInstitution,

            groupCreatorPhoneNumber: group4CreatorPhoneNumber,
            groupCreatorImageURL: `/${host}/group_members/${group4Id}/profile_images/${group4CreatorPhoneNumber}.webp`,
            groupCreatorUsername: group4CreatorUsername,
            isActive: true,
            maxNoOfMembers: 5, // 5

            groupMembers: group4Members,
            activationRequest: null,
        };

        let groupReference;
        groupReference = getFirestore().collection("groups").doc(group1.groupId);
        await groupReference.set(group1);

        groupReference = getFirestore().collection("groups").doc(group2.groupId);
        await groupReference.set(group2);

        groupReference = getFirestore().collection("groups").doc(group3.groupId);
        await groupReference.set(group3);

        groupReference = getFirestore().collection("groups").doc(group4.groupId);
        await groupReference.set(group4);

    }
}

export default DurbanCentralFakeGroups