/* eslint-disable*/
import { getFirestore } from "firebase-admin/firestore";
class HowardFakeGroups {

    constructor() {

    }

    // Images exist on emulator [Real Areas & Fake Members]
    async onCompusGroups() {

        const host = "howard college (ukzn)";
        const group1Members = ["+27801111111", "+27811111111", "+27821111111", "+27831111111", "+27841111111"];
        const group1CreatorPhoneNumber = "+27801111111";
        const group1Id = "howard-collage-fake-group-1";

        const group2Members = ["+27802222222", "+27812222222", "+27822222222", "+27832222222", "+27842222222"];
        const group2CreatorPhoneNumber = "+27802222222";
        const group2Id = "howard-collage-fake-group-2";

        const group3Members = ["+27803333333", "+27813333333", "+27823333333", "+27833333333", "+27843333333"];
        const group3CreatorPhoneNumber = "+27803333333";
        const group3Id = "howard-collage-fake-group-3";

        const group4Members = ["+27804444444", "+27844444444", "+27824444444", "+27834444444", "+27844444444"];
        const group4CreatorPhoneNumber = "+27804444444";
        const group4Id = "howard-collage-fake-group-4";

        const group5Members = ["+27805555555", "+27815555555", "+27825555555", "+27835555555", "+27845555555"];
        const group5CreatorPhoneNumber = "+27805555555";
        const group5Id = "howard-collage-fake-group-5";

        const group6Members = ["+27806666666", "+27846666666", "+278246666666", "+27836666666", "+27846666666"];
        const group6CreatorPhoneNumber = "+27806666666";
        const group6Id = "howard-collage-fake-group-6";

        const group1Area = {
            townOrInstitutionFK: "4",
            areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "30",
        };
        const specificArea1 = 'John Bews';

        const group2Area = {
            townOrInstitutionFK: "4",
            areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "30",
        };
        const specificArea2 = 'Mabel Palmer Hall';

        const group3Area = {
            townOrInstitutionFK: "4",
            areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "30",
        };
        const specificArea3 = 'Puis Langa';

        const group4Area = {
            townOrInstitutionFK: "4",
            areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "30",
        };
        const specificArea4 = 'Townley Williams Hall';

        const group5Area = {
            townOrInstitutionFK: "4",
            areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "30",
        };
        const specificArea5 = 'Charles James Hall';

        const group6Area = {
            townOrInstitutionFK: "4",
            areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
            areaNo: "30",
        };
        const specificArea6 = 'Ansell May Hall';

        const groupTownOrInstitution = {
            cityFK: "1",
            townOrInstitutionName: "Howard College UKZN",
            townOrInstitutionNo: "4",
        };

        const groupName1 = "Angels";
        const group1CreatorUsername = "Monica";

        const groupName2 = "Night Riders";
        const group2CreatorUsername = "Cat";

        const groupName3 = "Engineers";
        const group3CreatorUsername = "Sam";

        const groupName4 = "Rangers";
        const group4CreatorUsername = "Jimmy";

        const groupName5 = "Nerds";
        const group5CreatorUsername = "Jacob";

        const groupName6 = "Zebras";
        const group6CreatorUsername = "Sanele";

        const group1 = {
            groupId: group1Id,
            groupName: groupName1,
            groupRegisteryAdminId: null,
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
            groupRegisteryAdminId: null,
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
            groupRegisteryAdminId: null,
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
            groupRegisteryAdminId: '4kVF6YK7Flc4nw31JQfDh0vZLFB2',
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

        const group5 = {
            groupId: group5Id,
            groupName: groupName5,
            groupRegisteryAdminId: '4kVF6YK7Flc4nw31JQfDh0vZLFB2',
            groupImageURL: `/${host}/groups_specific_locations/${group5Id}.jpg`,
            groupArea: group5Area,
            groupSpecificArea: specificArea5,
            groupTownOrInstitution: groupTownOrInstitution,

            groupCreatorPhoneNumber: group5CreatorPhoneNumber,
            groupCreatorImageURL: `/${host}/group_members/${group5Id}/profile_images/${group5CreatorPhoneNumber}.webp`,
            groupCreatorUsername: group5CreatorUsername,
            isActive: true,
            maxNoOfMembers: 5, // 5

            groupMembers: group5Members,
            activationRequest: null,
        };

        const group6 = {
            groupId: group6Id,
            groupName: groupName6,
            groupRegisteryAdminId: '4kVF6YK7Flc4nw31JQfDh0vZLFB2',
            groupImageURL: `/${host}/groups_specific_locations/${group6Id}.jpg`,
            groupArea: group6Area,
            groupSpecificArea: specificArea6,
            groupTownOrInstitution: groupTownOrInstitution,

            groupCreatorPhoneNumber: group6CreatorPhoneNumber,
            groupCreatorImageURL: `/${host}/group_members/${group6Id}/profile_images/${group6CreatorPhoneNumber}.webp`,
            groupCreatorUsername: group6CreatorUsername,
            isActive: true,
            maxNoOfMembers: 5, // 5

            groupMembers: group6Members,
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

        groupReference = getFirestore().collection("groups").doc(group5.groupId);
        await groupReference.set(group5);

        groupReference = getFirestore().collection("groups").doc(group6.groupId);
        await groupReference.set(group6);

    }

}

export default HowardFakeGroups