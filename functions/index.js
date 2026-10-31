/* eslint-disable*/
"use strict";

// [START all]
// [START import]
// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
import { logger } from "firebase-functions";

import { onDocumentCreated, onDocumentDeleted, onDocumentUpdated }
    from "firebase-functions/v2/firestore";

import { onCall } from "firebase-functions/v2/https";

import { onRequest } from "firebase-functions/v2/https";

// The Firebase Admin SDK to access Firestore.
import { initializeApp, applicationDefault } from "firebase-admin/app";
import { getAuth } from "firebase-admin/auth";
import { getFirestore, Timestamp } from "firebase-admin/firestore";

import { debug, log } from "firebase-functions/logger";

import { onSchedule } from "firebase-functions/v2/scheduler";

const liveCometitionsRuntimeOpts = {
    timeoutSeconds: 420,
    memory: "1GiB",
    minInstances: 5
};

const pickingMultipleInSeconds = 3;
const maxNumberOfGroupCompetitors = 200;

initializeApp({
    credential: applicationDefault(),
    databaseURL: 'https://wow-we-won.firebaseio.com'
});

/*
initializeApp({
  credential: credential.cert(serviceAccount),
  databaseURL: 'https://wow-we-won.firebaseio.com'
}); */


import CountriesCreation from "./models/locations/countries-creation.js";
import ProvinciesOrStatesCreation from "./models/locations/provinces-or-states-creation.js";
import CitiesCreation from "./models/locations/cities-creation.js";
import TownsOrInstitutionsCreation from "./models/locations/towns-or-institutions-creation.js";
import AreasCreation from "./models/locations/areas-creation.js";



import HowardFakeGroups from "./models/users/groups/howard_fake_groups.js";
import DurbanCentralFakeGroups from "./models/users/groups/durban_central_fake_groups.js";

import FakeAdmins from "./models/users/fake_admins.js";
import FakeUsers from "./models/users/fake_users.js";

const howardFakeGroups = new HowardFakeGroups();
const durbanCentralFakeGroups = new DurbanCentralFakeGroups();

const fakeAdmins = new FakeAdmins();
const fakeUsers = new FakeUsers();


// http://127.0.0.1:5001/wow-we-won/africa-south1/createSupportedLocations/
// http://127.0.0.1:5001/wow-we-won/africa-south1/createFakeUsers
// http://127.0.0.1:5001/wow-we-won/africa-south1/saveHostingAreas
// http://127.0.0.1:5001/wow-we-won/africa-south1/saveFakeAdmins
// http://127.0.0.1:5001/wow-we-won/africa-south1/createFakeGroups?hostIndex=7
// http://127.0.0.1:5001/wow-we-won/africa-south1/createFakeDraws?hostIndex=7
// http://127.0.0.1:5001/wow-we-won/africa-south1/convertToCompetitions
// http://127.0.0.1:5001/wow-we-won/africa-south1/createFakeActivationRequests

// https://createsupportedlocations-nhbcmt2z5a-bq.a.run.app
// https://createfakeusers-nhbcmt2z5a-bq.a.run.app
// https://savehostingareas-nhbcmt2z5a-bq.a.run.app
// https://savefakeadmins-nhbcmt2z5a-bq.a.run.app
// https://createfakegroups-nhbcmt2z5a-bq.a.run.app?hostIndex=2
// https://createfakedraws-nhbcmt2z5a-bq.a.run.app?hostIndex=2
// https://converttocompetitions-nhbcmt2z5a-bq.a.run.app
// https://createfakeactivationrequests-nhbcmt2z5a-bq.a.run.app



// ###################Production Functions [Start]########################

// ==============================On Request [Start]==============================

// http://127.0.0.1:5001/wow-we-won/africa-south1/createSupportedLocations/
export const createSupportedLocations = onRequest(
    { region: "africa-south1" },
    async (req, res) => {

        const countriesCreation = new CountriesCreation();
        await countriesCreation.createSupportedCountries();
        const provinciesOrStatesCreation = new ProvinciesOrStatesCreation();
        await provinciesOrStatesCreation.createSupportedProvincesOrStates()
        const citiesCreation = new CitiesCreation();
        await citiesCreation.createSupportedCities();
        const townsOrInstitutionsCreation = new TownsOrInstitutionsCreation();
        await townsOrInstitutionsCreation.createSupportedTownsOrInstitutions();
        const areasCreation = new AreasCreation();
        await areasCreation.createSupportedAreas();
        res.json({ result: `Supported Areas Created Successfully.` });
    });

// http://127.0.0.1:5001/wow-we-won/africa-south1/saveHostingAreas
export const saveHostingAreas = onRequest(
    { region: "africa-south1" },
    async (req, res) => {

        let hostingArea;
        let hostingAreaReference;

        // Town/Institution 1
        hostingArea = {
            hostingAreaId: "g4drbsfkrnds48dnmd",
            hostingAreaName: "Durban Central",
            hostingAreaImageURL: "hosting_areas/g4drbsfkrnds48dnmd.jpg",
            sectionName: "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa",
            pickUpArea: "Berea (Mobile)",
        };

        hostingAreaReference = getFirestore().collection("hosting_areas")
            .doc(hostingArea.hostingAreaId);

        await hostingAreaReference.set(hostingArea);

        // Town/Institution 2
        hostingArea = {
            hostingAreaId: "d4drbsfkrnds48dnmd",
            hostingAreaName: "UKZN",
            hostingAreaImageURL: "hosting_areas/d4drbsfkrnds48dnmd.jpg",
            sectionName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
            pickUpArea: "Howard College (Mobile)",
        };

        hostingAreaReference = getFirestore().collection("hosting_areas")
            .doc(hostingArea.hostingAreaId);

        await hostingAreaReference.set(hostingArea);

        // Send back a message that we"ve successfully written to the db.
        res.json({ result: `All Hosting Areas Are Saved.` });
    });

export const convertToCompetitions =

    onRequest(
        {
            region: "africa-south1"
        },
        async (req, res) => {

            try {
                // Consistent timestamp
                const justNow = Timestamp.now().toDate();

                // const justNow = new Date();// Retrieve Current Time.

                // Use the get() method for a read and the onSnapshot() for real time read.
                getFirestore().collectionGroup("hosted_draws").orderBy("hostingAreaName")
                    .where("drawDateAndTime.year",
                        "==", justNow.getFullYear(),
                    )
                    .where("drawDateAndTime.month",
                        "==", justNow.getMonth() + 1, // 1-12
                    )
                    .where("drawDateAndTime.day",
                        "==", justNow.getDate(),
                    )
                    .where("drawDateAndTime.hour",
                        "==", justNow.getHours() + 2, // GTM
                    ) /*
                    .where("drawDateAndTime.minute",
                        "==", justNow.getMinutes() + 1,
                    ) */
                    // Can Be A Bit Tricky If You Think About It.
                    // As a result competitions shouldn't start at o'clock.
                    // Find competitions starting in the next minute.

                    // Index creation is required.
                    .where("drawDateAndTime.minute",
                        "<=", justNow.getMinutes() + 3,
                    )
                    .onSnapshot(async (hostedDrawsSnapshot) => {

                        if (hostedDrawsSnapshot.size > 0) {
                            // log(`# No of draws ${hostedDrawsSnapshot.size}`);

                            hostedDrawsSnapshot.docs.map(async (hostedDrawDoc) => {
                                const batch = getFirestore().batch();
                                const townOrInstitution = hostedDrawDoc.data()["townOrInstitution"];

                                /* Only initiate the conversion step if there are
                                groups belonging in a section which is the same
                                as the store draw's.*/
                                getFirestore().collection("groups")
                                    .where("groupArea.townOrInstitutionFK", "==", townOrInstitution.townOrInstitutionNo)
                                    .where("isActive", "==", true)
                                    .onSnapshot(async (groupsSnapshot) => {
                                        // log(`# No of groups ${groupsSnapshot.size}`);
                                        if (groupsSnapshot.size > 0) {

                                            const hostedDrawId = hostedDrawDoc.data()["hostedDrawId"];

                                            const hostedDraw = {
                                                hostedDrawId: hostedDrawId,
                                                hostingAreaFK: hostedDrawDoc.data()["hostingAreaFK"],
                                                drawDateAndTime:
                                                    hostedDrawDoc.data()["drawDateAndTime"],
                                                joiningFee: hostedDrawDoc.data()["joiningFee"],
                                                numberOfGrandPrices:
                                                    hostedDrawDoc.data()["numberOfGrandPrices"],
                                                numberOfGroupCompetitorsSoFar:
                                                    hostedDrawDoc.data()["numberOfGroupCompetitorsSoFar"],
                                                isOpen: hostedDrawDoc.data()["isOpen"],
                                                hostingAreaName: hostedDrawDoc.data()["hostingAreaName"],
                                                hostingAreaImageURL:
                                                    hostedDrawDoc.data()["hostingAreaImageURL"],
                                                grandPriceToWinIndex:
                                                    hostedDrawDoc.data()["grandPriceToWinIndex"],
                                                townOrInstitution: townOrInstitution,
                                                groupToWinPhoneNumber: hostedDrawDoc.data()["groupToWinPhoneNumber"],
                                                groupToWinId: hostedDrawDoc.data()["groupToWinId"],
                                            };

                                            const reference = getFirestore()
                                                .collection("competitions")
                                                // .doc();
                                                .doc(hostedDrawId);


                                            const timeBetweenPricePickingAndGroupPicking = pickingMultipleInSeconds * 3;
                                            const displayPeriodAfterWinners = pickingMultipleInSeconds * 10;

                                            /**
                                            * Single Competition Time Interval [Based On 3 Seconds Multiple]
                                            * First 1 minute - Remaining Time Count Down
                                            * Next 18 seconds - Grand Price Picking
                                            * Next 3*3 seconds - Won Price Display
                                            * Next 600 seconds Max - Group Picking
                                            * Next 6 seconds - Notification
                                            * Next 30 Seconds - Competition Result Display
                                            * Last 3 seconds - Game Over
                                            * Total Time = 1 min + 10 min + 30 sec + 18 sec + 9 sec = 11 min 57 seconds
                                            * Gap Between Competitions - 1 minute
                                            */

                                            const competition = {
                                                competitionId: reference.id,
                                                hostingAreaFK: hostedDraw.hostingAreaFK,
                                                competitionTownOrInstitution: hostedDraw.townOrInstitution,
                                                isLive: true,
                                                dateTime: hostedDraw.drawDateAndTime,
                                                joiningFee: hostedDraw.joiningFee,
                                                numberOfGrandPrices: hostedDraw.numberOfGrandPrices,
                                                isOver: false,
                                                grandPricesGridId: "-",
                                                competitorsGridId: "-",
                                                groupPickingStartTime: -1,
                                                pickingMultipleInSeconds: pickingMultipleInSeconds,
                                                timeBetweenPricePickingAndGroupPicking: timeBetweenPricePickingAndGroupPicking,
                                                displayPeriodAfterWinners: displayPeriodAfterWinners,

                                                grandPricesOrder: [],
                                                isWonGrandPricePicked: false,
                                                competitorsOrder: [],
                                                isWonCompetitorGroupPicked: false,
                                                competitionState: "on-count-down",
                                                wonPrice: null,
                                                wonGroup: null,
                                                grandPriceToWinIndex: hostedDraw.grandPriceToWinIndex,
                                                groupToWinPhoneNumber: hostedDraw.groupToWinPhoneNumber,
                                                groupToWinId: hostedDraw.groupToWinId

                                            };

                                            // log(`Group To Win ${hostedDraw.groupToWinId}`);

                                            batch.create(reference, competition);
                                            batch.update(hostedDrawDoc.ref, { hostedDrawState: "converted-to-competition" });
                                            batch.update(hostedDrawDoc.ref, { isOpen: false });
                                            await batch.commit();
                                        }
                                    });
                            });
                        }
                    });

                res.json({ result: `Done Converting Store Draws Into Competitions.` });
            }
            catch (e) {
                logger.log(e);
            } finally {

            }
        });

// ==============================On Request [End]==============================

// ==============================On Document Created [Start]==============================

/* Each time a new store is created, it has to have a corresponding store name
info document which is responsible for holding information that users
will be seeing, like a store"s current state(hasNoCompetition,
hasUpcommingCompetition, etc.) for example. */
export const createHostInfo = onDocumentCreated({
    document: "/hosting_areas/" +
        "{hostingAreaId}",
    region: "africa-south1"
}, async (event) => {
    // Access the parameter `{storeId}` with `event.params`
    /*logger.log("From Params Hosting Area ID", event.params.hostingAreaId,
        "From Data Hosting Area ID", event.data.data().hostingAreaId); */

    /* Create a document reference in order to associate it id with the
                                stores"s id.*/
    const docReference = getFirestore()
        .collection("hosts_info").doc(event.params.hostingAreaId);

    // Grab the current values of what was written to the stores collection.
    const hostInfo = {
        hostInfoId: event.data.data().hostingAreaId,
        hostingAreaName: event.data.data().hostingAreaName,
        hostingAreaImageURL: event.data.data().hostingAreaImageURL,
        sectionName: event.data.data().sectionName,
        pickUpArea: event.data.data().pickUpArea,
        canAddDraw: true,
        latestHostedDrawId: "-",
        drawsOrder: [],
        notification: null,
    };
    /*logger.log(`About To Add A Host Info Object With ID
    ${hostInfo.hostInfoId} To The Database.`); */

    // Push the new store into Firestore using the Firebase Admin SDK.
    return await docReference.set(hostInfo);
});

export const createGrandPricesGrid =
    onDocumentCreated(
        {
            document: "/competitions/{competitionId}",
            region: "africa-south1"
        }, async (event) => {
            const competitionId = event.data.data()["competitionId"];
            const numberOfGrandPrices = event.data.data()["numberOfGrandPrices"];
            const hostingAreaFK = event.data.data()["hostingAreaFK"];
            const grandPriceToWinIndex = event.data.data()["grandPriceToWinIndex"];

            getFirestore()
                .collection("competitions")
                .doc(competitionId)
                .collection("grand_prices_grids")
                .onSnapshot(async (grandPricesGridSnapshot) => {
                    // Only add a new grand price grid if one does not exist yet.
                    if (grandPricesGridSnapshot.size == 0) {
                        /* Convert each drawGrandPrice into a
                            grandPriceToken and save it.*/
                        const reference = getFirestore()
                            .collection("competitions")
                            .doc(competitionId)
                            .collection("grand_prices_grids")
                            .doc();

                        // Step 4
                        let grandPricesOrder = [];

                        // Make sure all grand prices are visited.
                        for (let index = 0; index < numberOfGrandPrices;
                            index++) {
                            grandPricesOrder.push(index);
                        }

                        // Suffle the list to make sure the order is random.
                        grandPricesOrder = shuffle(grandPricesOrder);

                        // Price To Win Index
                        // grandPricesOrder.push(Math.floor(Math.random() * numberOfGrandPrices));
                        if (grandPriceToWinIndex != -1) {
                            grandPricesOrder.push(grandPriceToWinIndex);
                        }
                        else {
                            grandPricesOrder.push(Math.floor(Math.random() * numberOfGrandPrices));
                        }


                        const grandPricesGrid = {
                            grandPricesGridId: reference.id,
                            competitionFK: competitionId,
                            numberOfGrandPrices: numberOfGrandPrices,
                            currentlyPointedTokenIndex: 0,
                            grandPricesOrder: grandPricesOrder,
                            hasStarted: false,
                            hasStopped: false,
                            hostingAreaFK: hostingAreaFK,
                        };

                        await reference.set(grandPricesGrid);

                        const competitionReference = getFirestore().collection("competitions").doc(competitionId);
                        await competitionReference.update({ grandPricesGridId: grandPricesGrid.grandPricesGridId });
                        await competitionReference.update({ grandPricesOrder: grandPricesGrid.grandPricesOrder });

                        const pickingMultipleInSeconds = event.data.data()["pickingMultipleInSeconds"];
                        const timeBetweenPricePickingAndGroupPicking = event.data.data()["timeBetweenPricePickingAndGroupPicking"];
                        const groupPickingStartTime = (grandPricesGrid.grandPricesOrder.length + 1) *
                            pickingMultipleInSeconds + timeBetweenPricePickingAndGroupPicking;

                        await competitionReference.update({ groupPickingStartTime: groupPickingStartTime });
                    }
                });
        });

export const createGrandPricesTokens =
    onDocumentCreated(
        {
            document: "/competitions/" +
                "{competitionId}/grand_prices_grids/" +
                "{grandPriceGridId}",
            region: "africa-south1"
        }, async (event) => {
            const competitionFK = event.data.data()["competitionFK"];
            const grandPricesGridId = event.data.data()["grandPricesGridId"];
            const hostingAreaFK = event.data.data()["hostingAreaFK"];
            const grandPricesOrder = event.data.data()["grandPricesOrder"];

            getFirestore()
                .collection("hosting_areas")
                .doc(hostingAreaFK)
                .collection("hosted_draws")
                .doc(competitionFK)
                .collection("draw_grand_prices")
                .onSnapshot(async (drawGrandPricesSnapshot) => {
                    if (drawGrandPricesSnapshot.size > 0) {
                        drawGrandPricesSnapshot.forEach(
                            async (drawGrandPrice) => {
                                // Remember there are n + 1 elements in the grand prices order list. [n = no of grand prices]
                                if (drawGrandPrice.data().grandPriceIndex == grandPricesOrder[drawGrandPricesSnapshot.size]) {
                                    // logger.log(`Grand Price Token - Won Price Index ${grandPricesOrder[drawGrandPricesSnapshot.size]}`);
                                    getFirestore()
                                        .collection("competitions")
                                        .doc(competitionFK).onSnapshot(async (competitionDoc) => {
                                            await competitionDoc.ref.update({
                                                wonPrice: drawGrandPrice.data(),
                                            });
                                        });
                                }

                                const tokenReference =
                                    getFirestore()
                                        .collection("competitions")
                                        .doc(competitionFK)
                                        .collection("grand_prices_grids")
                                        .doc(grandPricesGridId)
                                        .collection("grand_prices_tokens")
                                        .doc();

                                const grandPriceToken = {
                                    grandPriceTokenId:
                                        tokenReference.id,
                                    grandPricesGridFK:
                                        grandPricesGridId,
                                    tokenIndex:
                                        drawGrandPrice.data().grandPriceIndex,
                                    isPointed:
                                        drawGrandPrice.data().grandPriceIndex == 0,
                                    imageURL:
                                        drawGrandPrice.data().imageURL,
                                    description:
                                        drawGrandPrice.data().description,
                                };
                                await tokenReference.set(grandPriceToken);
                            });
                    }
                });
        });

export const createGroupCompetitiorsGrid =
    onDocumentCreated(
        {
            document: "/competitions/{competitionId}",
            region: "africa-south1"
        }, async (event) => {
            const competitionId = event.data.data()["competitionId"];
            const hostingAreaFK = event.data.data()["hostingAreaFK"];
            const townOrInstitution = event.data.data()["competitionTownOrInstitution"];
            const joiningFee = event.data.data()["joiningFee"];
            const groupToWinPhoneNumber = event.data.data()["groupToWinPhoneNumber"];
            const groupToWinId = event.data.data()["groupToWinId"];

            getFirestore()
                .collection("competitions")
                .doc(competitionId)
                .collection("group_competitors_grids")
                .onSnapshot(async (groupCompetitorsGridSnapshot) => {
                    // log(`Groups Snapshot Size ${groupCompetitorsGridSnapshot.size}`);
                    // Only add a new group competitors grid if one does not exist yet.
                    if (groupCompetitorsGridSnapshot.size == 0) {
                        getFirestore()
                            .collection("groups")
                            .where("groupArea.townOrInstitutionFK", "==", townOrInstitution.townOrInstitutionNo)
                            .where("isActive", "==", true)
                            .get().then(async (groupsSnapshot) => {
                                log(`No Of Qualifying Groups ${groupsSnapshot.size}`);
                                if (groupsSnapshot.size > 0) {
                                    const reference = getFirestore()
                                        .collection("competitions")
                                        .doc(competitionId)
                                        .collection("group_competitors_grids")
                                        .doc();

                                    const numberOfGroupCompetitorsSoFar = groupsSnapshot.size;
                                    const groupCompetitorsGridId = reference.id;

                                    let competitorsOrder = new Array();
                                    let competitorIdentifier;


                                    // Make sure all competitors are visited.
                                    groupsSnapshot.docs.forEach((groupDoc) => {
                                        competitorIdentifier = `${groupDoc.data()['groupCreatorPhoneNumber']} ${groupDoc.data()['groupId']}`;
                                        // log(`Competitor Identifier ${competitorIdentifier}`);
                                        // Before [groupDoc.id === groupToWinPhoneNumber]
                                        if (!(groupDoc.id === groupToWinId)) {
                                            if (groupDoc.data()['isActive']) {


                                                // For example +27714294948 afkljafkjlhlfa
                                                competitorsOrder.push(competitorIdentifier);
                                            }

                                        }

                                        // Make sure competitors are visited randomly.
                                        competitorsOrder = shuffle(competitorsOrder);


                                    });

                                    // No Group Picking Strategy Applied.
                                    if (groupsSnapshot.size > maxNumberOfGroupCompetitors) {
                                        let newCompetitorsList = [];
                                        for (let i = 0; i < maxNumberOfGroupCompetitors - 1; i++) {
                                            newCompetitorsList.push(competitorsOrder[i]);
                                        }
                                        competitorIdentifier = `${groupToWinPhoneNumber} ${groupToWinId}`;
                                        newCompetitorsList.push(competitorIdentifier);
                                        competitorsOrder = newCompetitorsList;
                                    }
                                    else {
                                        competitorIdentifier = `${groupToWinPhoneNumber} ${groupToWinId}`;
                                        competitorsOrder.push(competitorIdentifier);
                                    }



                                    // const hostGroups = groupsSnapshot.docs;
                                    // competitorsOrder = findCompetitorsOrder(groupsSnapshot.docs, townOrInstitution.townOrInstitutionName);

                                    const groupCompetitorsGrid = {
                                        competitorsGridId: groupCompetitorsGridId,
                                        competitionFK: competitionId,
                                        numberOfGroupCompetitors:
                                            numberOfGroupCompetitorsSoFar,
                                        currentlyPointedTokenIndex: 0,
                                        competitorsOrder:
                                            competitorsOrder,
                                        hasStarted: false,
                                        hasStopped: false,
                                        hostingAreaFK: hostingAreaFK,
                                        townOrInstitution: townOrInstitution,
                                    };

                                    await reference.set(groupCompetitorsGrid);

                                    const competitionReference = getFirestore().collection("competitions").doc(competitionId);
                                    await competitionReference.update({ competitorsGridId: groupCompetitorsGrid.competitorsGridId });
                                    await competitionReference.update({ competitorsOrder: groupCompetitorsGrid.competitorsOrder });
                                }
                            });
                    }
                });
        });

export const createGroupCompetitorsTokens =
    onDocumentCreated(
        {
            document: "/competitions/" +
                "{competitionId}/group_competitors_grids/" +
                "{groudCompetitorGridId}",
            region: "africa-south1"
        }, async (event) => {
            const competitionFK =
                event.data.data()["competitionFK"];
            const competitionTownOrInstitution =
                event.data.data()["townOrInstitution"];

            const groupCompetitorsGridId =
                event.data.data()["competitorsGridId"];

            const competitorsOrder = event.data.data()["competitorsOrder"];

            getFirestore()
                .collection("groups")
                .where("groupTownOrInstitution.townOrInstitutionNo", "==", competitionTownOrInstitution.townOrInstitutionNo)
                .onSnapshot(
                    async (groupsSnapshot) => {
                        if (groupsSnapshot.size > 0) {

                            for (let groupIndex = 0; groupIndex <
                                groupsSnapshot.size; groupIndex++) {
                                const groupDoc =
                                    groupsSnapshot.docs.at(groupIndex);

                                const competitorPhoneNumberPlusId = `${groupDoc.data().groupCreatorPhoneNumber} ${groupDoc.data().groupId}`;

                                // Last Group Wins.
                                if (competitorPhoneNumberPlusId === competitorsOrder[groupsSnapshot.size - 1]) {
                                    // logger.log(`Competitor Token - Group Creator Leader ${competitorsOrder[groupsSnapshot.size - 1]}`);
                                    getFirestore()
                                        .collection("competitions")
                                        .doc(competitionFK).onSnapshot((competitionDoc) => {
                                            competitionDoc.ref.update({
                                                wonGroup: groupDoc.data(),
                                            });
                                        });
                                }

                                const tokenDocReference =
                                    getFirestore()
                                        .collection("competitions")
                                        .doc(competitionFK)
                                        .collection("group_competitors_grids")
                                        .doc(groupCompetitorsGridId)
                                        .collection("group_competitors_tokens")
                                        .doc();

                                const groupCompetitorToken = {
                                    groupCompetitorTokenId:
                                        tokenDocReference
                                            .id,
                                    groupCompetitorsGridFK:
                                        groupCompetitorsGridId,
                                    tokenIndex: groupIndex,
                                    group: groupDoc.data(),
                                };

                                await tokenDocReference
                                    .set(groupCompetitorToken);
                            }
                        }
                    });
        });

export const setRecruitmentHistoryDate = onDocumentCreated(
    {
        document: "/recruitment_history/{recruitmentHistoryId}",
        region: "africa-south1"
    }, async (event) => {

        const docReference = getFirestore()
            .collection("recruitment_history").doc(event.params.recruitmentHistoryId);

        const dateObject = Timestamp.now().toDate();

        const year = dateObject.getFullYear();
        const month = dateObject.getMonth() + 1;
        const date = dateObject.getDate();
        const hour = dateObject.getHours() + 2;
        const minute = dateObject.getMinutes();

        const dateMap = {
            'year': year,
            'month': month,
            'date': date,
            'hour': hour,
            'minute': minute
        };

        await docReference.update({ dateCreated: dateMap });
        // log('Update Performed...');
    });

export const updateActivationRequestAndGroup = onDocumentCreated({
    document: "/activation_requests/" +
        "{activationReqeustId}",
    region: "africa-south1"
}, async (event) => {

    /*logger.log("From Params ActivationReqeust ID", event.params.activationRequestId,
        "From Data ActivationRequest ID", event.data.data().activationRequestId);*/

    const now = Timestamp.now();
    const dateObject = now.toDate();

    const year = dateObject.getFullYear();
    const month = dateObject.getMonth() + 1;
    const date = dateObject.getDate();
    const hour = dateObject.getHours() + 2;
    const minute = dateObject.getMinutes();
    const second = dateObject.getSeconds();

    const requestDate = {
        'year': year,
        'month': month,
        'day': date,
        'hour': hour,
        'minute': minute,
        'second': second,
    };



    // logger.log(`About To Set A Request Date For An ActivationRequest...`);
    const activationRequestReference = getFirestore()
        .collection("activation_requests").doc(event.data.data().activationRequestId);
    await activationRequestReference.update({
        requestDate: requestDate,
        requestDateTimestamp: now,
    });

    const groupReference = getFirestore()
        .collection("groups").doc(event.data.data().groupFK);


    const activationRequest = {
        activationRequestId: event.data.data().activationRequestId,
        voucherType: event.data.data().voucherType,
        requestDate: requestDate,
        moneyCollectorFK: event.data.data().moneyCollectorFK,
        requestDateTimestamp: event.data.data().requestDateTimestamp,
        groupFK: event.data.data().groupFK,
        groupCreatorImageURL: event.data.data().groupCreatorImageURL,
        voucher: event.data.data().voucher,
        isApproved: event.data.data().isApproved,
        isChecked: event.data.data().isChecked
    };
    /*logger.log(`About To Update An Activation Reqeust For A Group Object With ID
    ${event.data.data().groupFK}.`);*/

    return await groupReference.update({
        activationRequest: activationRequest
    });
});

/* Make sure all competitions start at an acceptable time,
like 08:30 for instance.*/
export const maintainCountDownClocks =
    onDocumentCreated(
        {
            document: "/competitions/{competitionId}",
            region: "africa-south1"
        },
        async (event) => {
            const day = event.data.data().dateTime["day"];
            const month = event.data.data().dateTime["month"];
            const year = event.data.data().dateTime["year"];
            const hour = event.data.data().dateTime["hour"];
            const minute = event.data.data().dateTime["minute"];


            const countDownId = `${year}-${month}-${day}@${hour}h${minute}`;

            const reference = getFirestore().collection("count_down_clocks")
                .doc(countDownId);

            reference.onSnapshot(async (snapshot) => {
                if (!snapshot.exists) {
                    // const joiningFee = event.data.data().dateTime["joiningFee"];
                    /**
                     * Single Competition Time Interval [Based On 3 Seconds Multiple]
                     * First 1 minute - Remaining Time Count Down
                     * Next 18 seconds - Grand Price Picking
                     * Next 3*3 = 9 seconds - Won Price Display
                     * Next 600 seconds Max - Group Picking
                     * Next 6 seconds - Display Notification
                     * Next 30 Seconds - Competition Result Display
                     * Last 12 seconds - Game Over
                     * Total Time = 1 min 18 sec + 9 sec+ 10 min + 6 seconds + 30 sec + 12 sec = 12 min 15 seconds
                     * Gap Between Competitions - 1 minute
                     */


                    // Remaining seconds should always start at -60 and stop at 735


                    let second = -pickingMultipleInSeconds * 20; // -60

                    // Maximum = 735
                    const max = pickingMultipleInSeconds * 6 + // Grand Price Picking
                        pickingMultipleInSeconds * 3 + // Won Price Display
                        pickingMultipleInSeconds * maxNumberOfGroupCompetitors + // Group Picking Max Time
                        pickingMultipleInSeconds * 2 + // Display Notification
                        pickingMultipleInSeconds * 10 + // Competition Result Display 
                        pickingMultipleInSeconds * 4; // Game Over

                    reference.set({
                        remainingTime: second,
                    });

                    const timerId = setInterval(async () => {
                        if (second > max) {
                            clearInterval(timerId);
                        }
                        else {
                            second += pickingMultipleInSeconds;
                        }
                        reference.set({
                            remainingTime: second,
                        });

                    }, pickingMultipleInSeconds * 1000);
                }
            });
        });

export const addNotification = onDocumentCreated(

    {
        document: "/notifications/" +
            "{notificationId}",
        region: "africa-south1"
    }, async (event) => {

        const notification = {
            notificationId: event.data.data().notificationId,
            message: event.data.data().message,
            audience: event.data.data().audience,
            endDate: {
                year: event.data.data().endDate.year,
                month: event.data.data().endDate.month,
                day: event.data.data().endDate.day
            },
            forAll: event.data.data().forAll
        }

        if (notification.forAll) {
            getFirestore().collection("hosts_info").onSnapshot((hostInfoSnapshot) => {
                // const batch = getFirestore().batch();
                hostInfoSnapshot.docs.map(async (hostInfoDoc) => {
                    if (hostInfoDoc.exists) {
                        await hostInfoDoc.ref.update({ notification: notification });
                        // batch.update(storeNameInfoDoc.ref, { notification: notification })
                    }
                })
                // batch.commit()
            })
        } else {
            getFirestore().collection("hosts_info").onSnapshot((hostInfoSnapshot) => {
                hostInfoSnapshot.docs.map(async (hostInfoDoc) => {
                    if (hostInfoDoc.exists) {
                        if (notification.audience.indexOf(hostInfoDoc.id) >= 0) {
                            await storeNameInfoDoc.ref.update({ notification: notification });
                        }
                    }
                })
            })
        }



    });

export const firstMoneyBagAndActivationRequestsUpdate = onDocumentCreated(

    {
        document: "/money_bags/" +
            "{moneyBagId}",
        region: "africa-south1"
    }, async (event) => {

        const batch = getFirestore().batch();

        const now = Timestamp.now();
        const justNow = {
            year: now.toDate().getFullYear(),
            month: now.toDate().getMonth() + 1,
            day: now.toDate().getDay(),
            hour: now.toDate().getHours() + 2,
            minute: now.toDate().getMinutes(),
        };

        let reference = getFirestore().collection("money_bags").doc(event.data.data().moneyCollectorBagId);



        /*await reference.update({
            moneyCollectorRecievedBy: justNow,
            moneyCollectorRecievedByTimeStamp: now,
        }); */

        batch.update(reference, {
            moneyCollectorRecievedBy: justNow,
            moneyCollectorRecievedByTimeStamp: now,
        });

        // Will be obtained from the relationship map object of the money bag.
        let groupFK;
        let activationRequestId;
        let color;

        for (const [key, value] of Object.entries(event.data.data().relationships)) {
            groupFK = key.split(' ')[0];
            activationRequestId = key.split(' ')[1];
            color = value;
            reference = getFirestore().collection('activation_requests').doc(activationRequestId);
            /*await reference.update({
                moneyCollectorFK: event.data.data().moneyCollectorBagId,
            }); */

            batch.update(reference, {
                moneyCollectorFK: event.data.data().moneyCollectorBagId,
            });

            reference = getFirestore().collection('groups').doc(groupFK);
            /*await reference.update({
                'activationRequest.moneyCollectorFK': event.data.data().moneyCollectorBagId,
            }); */

            batch.update(reference, {
                'activationRequest.moneyCollectorFK': event.data.data().moneyCollectorBagId,
            });
        }

        batch.commit();

    });

// ==============================On Document Created [End]==============================



// ==============================On Document Updated [Start]==============================

/* eslint brace-style: ["warn", "stroustrup"]*/
export const setIsLiveAndIsOverForQualifyingCompetitions = onDocumentUpdated(
    {
        document: "/count_down_clocks/{clockId}",
        region: "africa-south1"
    }
    , async (event) => {

        // 2026-3-25@8h25
        const clockId = event.params.clockId;

        const clockReference = getFirestore().collection("count_down_clocks")
            .doc(clockId);


        clockReference.onSnapshot(
            async (doc) => {
                // The remaining time for competitions to start.
                const remainingTime = doc.data().remainingTime;

                const datePieces = clockId.split("-"); // 2026 3 25@8h25

                const year = datePieces[0]; // 2026
                const month = datePieces[1]; // 3
                const portion1 = datePieces[2].split('@'); // 25 8h25

                const day = portion1[0]; // 25
                const anotherPortion = portion1[1].split('h'); // 8 25

                // 8
                const hour = anotherPortion[0];
                // 25
                const minute = anotherPortion[1];




                getFirestore().collection("competitions")
                    .onSnapshot(async (competitionsSnapshot) => {

                        if (competitionsSnapshot.size > 0) {
                            competitionsSnapshot.docs.map(async (competitionDoc) => {

                                const grandPricePickingDuration =
                                    competitionDoc.data().grandPricesOrder.length *
                                    competitionDoc.data().pickingMultipleInSeconds;

                                const groupPickingDuration =
                                    competitionDoc.data().competitorsOrder.length *
                                    competitionDoc.data().pickingMultipleInSeconds;

                                const competitionTotalDuration =
                                    grandPricePickingDuration +
                                    competitionDoc.data().timeBetweenPricePickingAndGroupPicking +
                                    groupPickingDuration;


                                if (competitionDoc.data().dateTime["day"] == day &&
                                    competitionDoc.data().dateTime["month"] == month &&
                                    competitionDoc.data().dateTime["year"] == year &&
                                    areHoursEqaul(competitionDoc.data().dateTime["hour"], hour) &&
                                    competitionDoc.data().dateTime["minute"] == minute
                                ) {


                                    /* Set isLive to true on corresponding competitions*/
                                    if (remainingTime == 0) {
                                        log('Set Competition To Live');
                                        // Set competition isLive value to true.
                                        competitionDoc.ref.update({
                                            isLive: true,
                                        });
                                    }

                                    else if (
                                        remainingTime > competitionTotalDuration + competitionDoc.data().displayPeriodAfterWinners + 9
                                        // remainingTime == competitionDoc.data().competitorsOrder.length * competitionDoc.data().pickingMultipleInSeconds
                                    ) {
                                        log('Competitions Attributes About To Change');
                                        // Set competition isOver value to true.
                                        competitionDoc.ref.update({
                                            isOver: true,
                                            isLive: false,
                                        });
                                    }


                                }
                            });
                        }
                    });

            });
    });

/* eslint max-len: ["off", { "code", 80, "comments": 80 }] */
// Multiple cpus/threads or batch write is needed here, other some won price summaries won be created.
export const createWonPriceSummary =
    onDocumentUpdated(
        {
            document: "/competitions/{competitionId}",
            region: "africa-south1"
        }, async (event) => {

            const reference = getFirestore()
                .collection("competitions")
                .doc(event.params.competitionId);


            reference.onSnapshot((competitionSnapshot) => {
                if (competitionSnapshot.exists) {
                    const isOver = competitionSnapshot.data().isOver;
                    const isLive = competitionSnapshot.data().isLive;


                    if (isOver && isLive) {
                        // log('Competition is isOver and isLive...');
                        reference.update({ isLive: false });
                        // log('Competition Is No Longer Live');
                        const wonPriceSummaryId =
                            competitionSnapshot.data().competitionId;
                        const hostingAreaFK =
                            competitionSnapshot.data().hostingAreaFK;

                        const wonPrice = competitionSnapshot.data()["wonPrice"];
                        const wonGroup = competitionSnapshot.data()["wonGroup"];
                        const groupToWinId = competitionSnapshot.data()["groupToWinId"];

                        // For Debugging Purposes.
                        // const competitorsOrder = competitionSnapshot.data()["competitorsOrder"];
                        // const grandPricesOrder = competitionSnapshot.data()["grandPricesOrder"];

                        // logger.log(`WonPriceSummary - ${wonGroup.groupCreatorPhoneNumber} ${competitorsOrder}`);
                        // logger.log(`WonPriceSummary - ${wonPrice.grandPriceIndex} ${grandPricesOrder}`);

                        const hostingAreaReference = getFirestore()
                            .collection("hosting_areas")
                            .doc(hostingAreaFK);

                        hostingAreaReference.onSnapshot(async (snapshot) => {
                            const hostingAreaName = snapshot.data().hostingAreaName;
                            const hostingAreaImageURL = snapshot.data().hostingAreaImageURL;
                            const sectionName = snapshot.data().sectionName;
                            const pickUpArea = snapshot.data().pickUpArea;



                            const wonPriceSummaryReference =
                                getFirestore()
                                    .collection("won_prices_summaries")
                                    .doc(wonPriceSummaryId);
                            const wonPriceSummary = {
                                wonGroupId: groupToWinId,
                                wonPriceSummaryId:
                                    wonPriceSummaryId,
                                hostingAreaFK: hostingAreaFK,
                                groupName: wonGroup.groupName,
                                groupSpecificArea: wonGroup.groupSpecificArea,
                                groupTownOrInstitution:
                                    wonGroup.groupTownOrInstitution,
                                groupArea:
                                    wonGroup.groupArea,
                                groupMembers: wonGroup.groupMembers,
                                grandPriceDescription:
                                    wonPrice.description,
                                wonGrandPriceImageURL: wonPrice.imageURL,
                                hostingAreaImageURL: hostingAreaImageURL,
                                hostName: hostingAreaName,
                                storeSection: sectionName,
                                pickUpSpot: pickUpArea,
                                wonDate: competitionSnapshot.data().dateTime,
                                groupCreatorUsername: wonGroup.groupCreatorUsername,
                                groupCreatorImageURL: wonGroup.groupCreatorImageURL,
                                groupCreatorPhoneNumber: wonGroup.groupCreatorPhoneNumber,
                                wonGroupId: groupToWinId,
                            };

                            // Create won price summary.
                            await wonPriceSummaryReference
                                .set(wonPriceSummary);

                            // log('Won Price Summary Saved...');

                            // Update corresponding store draw.
                            getFirestore()
                                .collection("hosting_areas")
                                .doc(hostingAreaFK)
                                .collection("hosted_draws")
                                .doc(wonPriceSummaryId)
                                .update({
                                    hostedDrawState: "competition-finished"
                                });
                            // log('Competition Finished...');
                        });
                    }
                }
            });
        });

export const approveOrDisapproveActivationRequests = onDocumentUpdated(

    {
        document: "/money_bags/" +
            "{moneyBagId}",
        region: "africa-south1"
    }, async (event) => {

        const reference = getFirestore()
            .collection("money_bags")
            .doc(event.data.data().moneyCollectorBagId);

        reference.onSnapshot((moneyBagSnapshot) => {
            if (moneyBagSnapshot.exists && moneyBagSnapshot.data().hasMoneyCollectorSubmitted) {
                // log('Money Bag Submitted...');
                const relationships = moneyBagSnapshot.data().relationships;

                relationships.forEach((value, key, map) => {
                    const activationRequestId = key.split(' ')[1];

                    const activationRequestReference = getFirestore()
                        .collection("activation_requests")
                        .doc(activationRequestId);

                    activationRequestReference.update({
                        isChecked: true,
                        isApproved: value === "green",
                    })
                });
            }
        });
    });

export const secondMoneyBagAndActivationRequestsUpdate = onDocumentUpdated(

    {
        document: "/money_bags/" +
            "{moneyBagId}",
        region: "africa-south1"
    }, async (event) => {

        let reference = getFirestore().collection("money_bags").doc(event.params.moneyBagId);



        reference.onSnapshot(async (moneyBagSnapshot) => {
            if (moneyBagSnapshot.exists && moneyBagSnapshot.data().hasMoneyCollectorSubmitted) {

                const now = Timestamp.now();
                const justNow = {
                    year: now.toDate().getFullYear(),
                    month: now.toDate().getMonth() + 1,
                    day: now.toDate().getDay(),
                    hour: now.toDate().getHours() + 2,
                    minute: now.toDate().getMinutes(),
                };

                if (moneyBagSnapshot.data().moneyCollectorSubmittedBy == null ||
                    moneyBagSnapshot.data().moneyCollectorSubmittedByTimeStamp == null) {
                    await reference.update({
                        moneyCollectorSubmittedBy: justNow,
                        moneyCollectorSubmittedByTimeStamp: now,
                    });
                }



                // Will be obtained from the relationship map object of the money bag.
                let groupFK;
                let activationRequestId;
                let color;

                for (const [key, value] of Object.entries(moneyBagSnapshot.data().relationships)) {
                    groupFK = key.split(' ')[0];
                    activationRequestId = key.split(' ')[1];
                    color = value;
                    reference = getFirestore().collection('activation_requests').doc(activationRequestId);
                    await reference.update({
                        isApproved: color === 'green',
                        isChecked: true,
                    });

                    reference = getFirestore().collection('groups').doc(groupFK);
                    await reference.update({
                        'activationRequest.isApproved': color === 'green',
                        'activationRequest.isChecked': true,
                    });
                }

                reference = getFirestore().collection("money_bags").doc(event.params.moneyBagId);
                // await reference.delete();
            }
        });

    });

// ==============================On Document Updated [End]==============================

// ==============================On Schedule [Start]==============================

// Remember to create an index for the function's query.
// onSchedule("*/5 * * * *", async (event) => { */
// Works fine with generated competitions' id, whether or not it does with custom ids depends on the creation of indexes.
// https://createcompetitions-m657yrz3kq-uc.a.run.app/
// http://127.0.0.1:5001/wow-we-won/africa-south1/createCompetitions
export const createCompetitions =
    onSchedule(

        {
            schedule: '4,17,30,43,56 17 * * FRI', // Every Friday Hour 17 Minute 4, 17, 30, 43 & 17
            // timeZone: 'Africa/Johannesburg', // Optional: specify a timezone
            // region: 'africa-south1', // Specified Region Not Supported.
        },
        // "4,17,30,43,56 17 * * FRI",
        async (event) => {
            /*onRequest(
                {
                    region: "africa-south1"
                },
                async (req, res) => {*/

            try {
                // Consistent timestamp
                const justNow = Timestamp.now().toDate();

                // const justNow = new Date();// Retrieve Current Time.

                // Use the get() method for a read and the onSnapshot() for real time read.
                getFirestore().collectionGroup("hosted_draws").orderBy("hostingAreaName")
                    .where("drawDateAndTime.year",
                        "==", justNow.getFullYear(),
                    )
                    .where("drawDateAndTime.month",
                        "==", justNow.getMonth() + 1, // 1-12
                    )
                    .where("drawDateAndTime.day",
                        "==", justNow.getDate(),
                    )
                    .where("drawDateAndTime.hour",
                        "==", justNow.getHours() + 2, // GTM
                    ) /*
                    .where("drawDateAndTime.minute",
                        "==", justNow.getMinutes() + 1,
                    ) */
                    // Can Be A Bit Tricky If You Think About It.
                    // As a result competitions shouldn't start at o'clock.
                    // Find competitions starting in the next minute.

                    // Index creation is required.
                    .where("drawDateAndTime.minute",
                        "<=", justNow.getMinutes() + 3,
                    )
                    .onSnapshot(async (hostedDrawsSnapshot) => {

                        if (hostedDrawsSnapshot.size > 0) {
                            // log(`# No of draws ${hostedDrawsSnapshot.size}`);

                            hostedDrawsSnapshot.docs.map(async (hostedDrawDoc) => {
                                const batch = getFirestore().batch();
                                const townOrInstitution = hostedDrawDoc.data()["townOrInstitution"];

                                /* Only initiate the conversion step if there are
                                groups belonging in a section which is the same
                                as the store draw's.*/
                                getFirestore().collection("groups")
                                    .where("groupArea.townOrInstitutionFK", "==", townOrInstitution.townOrInstitutionNo)
                                    .where("isActive", "==", true)
                                    .onSnapshot(async (groupsSnapshot) => {
                                        // log(`# No of groups ${groupsSnapshot.size}`);
                                        if (groupsSnapshot.size > 0) {

                                            const hostedDrawId = hostedDrawDoc.data()["hostedDrawId"];

                                            const hostedDraw = {
                                                hostedDrawId: hostedDrawId,
                                                hostingAreaFK: hostedDrawDoc.data()["hostingAreaFK"],
                                                drawDateAndTime:
                                                    hostedDrawDoc.data()["drawDateAndTime"],
                                                joiningFee: hostedDrawDoc.data()["joiningFee"],
                                                numberOfGrandPrices:
                                                    hostedDrawDoc.data()["numberOfGrandPrices"],
                                                numberOfGroupCompetitorsSoFar:
                                                    hostedDrawDoc.data()["numberOfGroupCompetitorsSoFar"],
                                                isOpen: hostedDrawDoc.data()["isOpen"],
                                                hostingAreaName: hostedDrawDoc.data()["hostingAreaName"],
                                                hostingAreaImageURL:
                                                    hostedDrawDoc.data()["hostingAreaImageURL"],
                                                grandPriceToWinIndex:
                                                    hostedDrawDoc.data()["grandPriceToWinIndex"],
                                                townOrInstitution: townOrInstitution,
                                                groupToWinPhoneNumber: hostedDrawDoc.data()["groupToWinPhoneNumber"],
                                                groupToWinId: hostedDrawDoc.data()["groupToWinId"],
                                            };

                                            const reference = getFirestore()
                                                .collection("competitions")
                                                // .doc();
                                                .doc(hostedDrawId);


                                            const timeBetweenPricePickingAndGroupPicking = pickingMultipleInSeconds * 3;
                                            const displayPeriodAfterWinners = pickingMultipleInSeconds * 10;

                                            /**
                                            * Single Competition Time Interval [Based On 3 Seconds Multiple]
                                            * First 1 minute - Remaining Time Count Down
                                            * Next 18 seconds - Grand Price Picking
                                            * Next 3*3 seconds - Won Price Display
                                            * Next 600 seconds Max - Group Picking
                                            * Next 6 seconds - Notification
                                            * Next 30 Seconds - Competition Result Display
                                            * Last 3 seconds - Game Over
                                            * Total Time = 1 min + 10 min + 30 sec + 18 sec + 9 sec = 11 min 57 seconds
                                            * Gap Between Competitions - 1 minute
                                            */

                                            const competition = {
                                                competitionId: reference.id,
                                                hostingAreaFK: hostedDraw.hostingAreaFK,
                                                competitionTownOrInstitution: hostedDraw.townOrInstitution,
                                                isLive: true,
                                                dateTime: hostedDraw.drawDateAndTime,
                                                joiningFee: hostedDraw.joiningFee,
                                                numberOfGrandPrices: hostedDraw.numberOfGrandPrices,
                                                isOver: false,
                                                grandPricesGridId: "-",
                                                competitorsGridId: "-",
                                                groupPickingStartTime: -1,
                                                pickingMultipleInSeconds: pickingMultipleInSeconds,
                                                timeBetweenPricePickingAndGroupPicking: timeBetweenPricePickingAndGroupPicking,
                                                displayPeriodAfterWinners: displayPeriodAfterWinners,

                                                grandPricesOrder: [],
                                                isWonGrandPricePicked: false,
                                                competitorsOrder: [],
                                                isWonCompetitorGroupPicked: false,
                                                competitionState: "on-count-down",
                                                wonPrice: null,
                                                wonGroup: null,
                                                grandPriceToWinIndex: hostedDraw.grandPriceToWinIndex,
                                                groupToWinPhoneNumber: hostedDraw.groupToWinPhoneNumber,
                                                groupToWinId: hostedDraw.groupToWinId

                                            };

                                            // log(`Group To Win ${hostedDraw.groupToWinId}`);

                                            batch.create(reference, competition);
                                            batch.update(hostedDrawDoc.ref, { hostedDrawState: "converted-to-competition" });
                                            batch.update(hostedDrawDoc.ref, { isOpen: false });
                                            await batch.commit();
                                        }
                                    });
                            });
                        }
                    });
                // res.json({ result: `Done Converting Store Draws Into Competitions.` });
            }
            catch (e) {
                logger.log(e);
            } finally {

            }
        });
// ==============================On Schedule [End]==============================

/*
export const setCurrentUID = onCall(
    { region: "africa-south1" },
    async (request) => {
        const authToken = request.data.token;
        const userId = request.data.userId;



        try {
            const userAuth = await getAuth()
                .verifyIdToken(authToken);

            logger.log(`Token Was Verified Successfully.`);

            if (userId != userAuth.uid) {
                // res.sendStatus(403);
                logger.log(`User Wasn't Identified Successfully.`);
                return false;
            }
            else {
                currentUID = userId;
                // res.sendStatus(200);
                logger.log(`User Was Identified Successfully. Token ${currentUID}`);
                return true;
            }
        }
        catch (error) {
            log(error);
            // res.sendStatus(401);
            logger.log(`Token Wasn't Verified Successfully.`);
            return false;
        }
    }); */

// declare the function
const shuffle = (array) => {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
};

const areHoursEqaul = (hour1, hour2) => {

    if (hour1 > 12) {
        if (hour2 > 12) {
            return hour1 % 24 == hour2 % 24;
        }
        else {
            return hour1 - 12 == hour2;
        }
    }
    else {
        if (hour2 > 12) {
            return hour2 % 24 == hour1;
        }
        else {
            return hour1 == hour2;
        }
    }

}


/*
const batchWriteTester = (async () => {
  getFirestore().collection("groups")
    .onSnapshot(async (groupsSnapshot) => {
      const batch = getFirestore().batch();
      groupsSnapshot.docs.map((groupDoc) => {
        batch.update(groupDoc.ref, { groupName: 'No Name' });
      });

      logger.debug("batch operation 1...");
      await batch.commit();

    });
});*/



// ##################Production Functions [End]########################

// ########Development Functions [Start]###############

// ========================================Create Groups Data[End]========================================

const listAllUsers = async (nextPageToken) => {
    // List batch of users, 1000 at a time.
    getAuth()
        .listUsers(1000, nextPageToken)
        .then((listUsersResult) => {
            listUsersResult.users.forEach((userRecord) => {
                // console.log('user', userRecord.toJSON());
            });
            if (listUsersResult.pageToken) {
                // List next batch of users.
                listAllUsers(listUsersResult.pageToken);

            }
        })
        .catch((error) => {
            // console.log('Error listing users:', error);
        });
};

// Marketing Strategy 1-1 : Use Specific Area Residence To Find Contributors.
// Marketing Strategy 1-2 : Use Kids Gift To Find Contributors.
// Marketing Strategy 1-2 : Approach Stores
// http://127.0.0.1:5001/wow-we-won/africa-south1/createFakeGroups
export const createFakeGroups = onRequest(
    {
        region: "africa-south1"
    },
    async (req, res) => {

        switch (parseInt(req.query.hostIndex)) {

            case 1: // Durban Central
                await durbanCentralFakeGroups.durbanCentralGroups();  // Marketing Strategy 2

                // Send back a message that we"ve successfully written to the db.
                res.json({ result: `All Durban Central Fake Groups Are Saved.` });
                break;

            case 2:// UKZN
                await howardFakeGroups.onCompusGroups();  // Marketing Strategy 1-1

                // Send back a message that we"ve successfully written to the db.
                res.json({ result: `All   Howard Fake Groups Are Saved.` });
                break;


        }
    });

// http://127.0.0.1:5001/wow-we-won/africa-south1/createFakeDraws
// Stop using this function because it HostedDraw objects do not have wonGroupId property.
export const createFakeDraws = onRequest(
    {
        region: "africa-south1"
    },
    async (req, res) => {
        const drawDateAndTime = new Date();
        const year = drawDateAndTime.getFullYear();
        const month = drawDateAndTime.getMonth() + 1;
        const date = drawDateAndTime.getDate();
        const hour = drawDateAndTime.getHours() + 2;

        const minute = drawDateAndTime.getMinutes() + 4;


        let reference;

        let hostingAreaFK;
        let hostingAreaName;
        let townOrInstitution;
        let groupToWinPhoneNumber;
        let groupToWinId;

        // Start listing users from the beginning, 1000 at a time.
        // listAllUsers();
        log('Reached One...')

        switch (parseInt(req.query.hostIndex)) {


            case 1: // Durban Central
                hostingAreaFK = "g4drbsfkrnds48dnmd";
                hostingAreaName = "Durban Central";
                townOrInstitution = {
                    cityFK: "1",
                    townOrInstitutionName: "Durban Central",
                    townOrInstitutionNo: "7",
                };
                groupToWinPhoneNumber = "+27600000000";
                groupToWinId = "dbn-central-fake-group-1";
                break;
            case 2: // UKZN
                hostingAreaFK = "d4drbsfkrnds48dnmd";
                hostingAreaName = "Howard College (UKZN)";
                townOrInstitution = {
                    cityFK: "1",
                    townOrInstitutionName: "Howard College UKZN",
                    townOrInstitutionNo: "4",
                };
                groupToWinPhoneNumber = "+27803333333";
                groupToWinId = "ukzn-fake-group-3";
                break;
        }


        const hostedDrawId =
            `${year}-${month}-${date}@${hour}h${minute}@${hostingAreaFK}`;

        const draw = {
            "hostedDrawId": hostedDrawId,
            "hostingAreaFK": hostingAreaFK,
            "groupToWinPhoneNumber": groupToWinPhoneNumber,
            "groupToWinId": groupToWinId,
            "drawDateAndTime": {
                "year": year,
                "month": month,
                "day": date,
                "hour": hour,
                "minute": minute,
            },
            "numberOfGrandPrices": 5,
            "isOpen": true,
            "hostingAreaName": hostingAreaName,
            "hostingAreaImageURL": `${hostingAreaName.toLowerCase()}/hosting_areas/${hostingAreaFK}.jpg`,
            "townOrInstitution": townOrInstitution,
            "joiningFee": 0,
            "hostedDrawState": "not-converted-to-competition",

            "grandPriceToWinIndex": -1,
        };

        reference = getFirestore().collection("hosting_areas")
            .doc(hostingAreaFK).collection("hosted_draws")
            .doc(hostedDrawId);
        await reference.set(draw);
        log('Reached Three...')


        let grandPrice;
        let extension = '.jpg';
        for (let priceIndex = 0; priceIndex < draw.numberOfGrandPrices; priceIndex++) {
            reference = getFirestore().collection("hosting_areas")
                .doc(hostingAreaFK).collection("hosted_draws")
                .doc(hostedDrawId).collection("draw_grand_prices")
                // .doc(`${hostedDrawId}-${priceIndex}`);
                .doc(`${priceIndex}`);

            let description;

            if (parseInt(req.query.hostIndex) == 1) {
                switch (priceIndex) {
                    case 0:
                        description = "";
                        break;
                    case 1:
                        description = "";
                        break;
                    case 2:
                        description = "";
                        break;
                    case 3:
                        description = "";
                        break;
                    default:
                        description = "";
                }
            }

            // Dubran Central
            else if (parseInt(req.query.hostIndex) == 2) {
                switch (priceIndex) {
                    case 0:
                        description = "";
                        break;
                    case 1:
                        description = "";
                        break;
                    case 2:
                        description = "";
                        break;
                    case 3:
                        description = "";
                        break;
                    default:
                        description = "";
                }
            }

            grandPrice = {
                "grandPriceId": reference.id,
                "hostedDrawFK": hostedDrawId,
                "imageURL": `${hostingAreaName.toLowerCase()}/grand_prices_images/${reference.id}${extension}`,
                "description": description,
                "grandPriceIndex": priceIndex,

            };

            await reference.set(grandPrice);
        }
        const hostInfoReference = getFirestore().collection("hosts_info").doc(hostingAreaFK);


        hostInfoReference.get().then(async (doc) => {
            if (doc.exists) {
                let drawsOrder = doc.data()['drawsOrder'];

                drawsOrder.push(hostedDrawId);
                await hostInfoReference.update({ drawsOrder: drawsOrder });
                drawsOrder = doc.data()['drawsOrder'];
            }
        });

        log('Reached Four...')

        await hostInfoReference.update({ latestHostedDrawId: hostedDrawId });
        // Send back a message that we"ve successfully written to the db.
        res.json({ result: `Fake Draws Saved.` });
    });

// http://127.0.0.1:5001/wow-we-won/africa-south1/updateFakeGroups
export const updateFakeGroups = onRequest(
    {
        region: "africa-south1"
    }, async (req, res) => {
        batchWriteTester();
        res.json({ result: `group batch updated.` });
    });

// http://127.0.0.1:5001/wow-we-won/africa-south1/saveFakeAdmins
export const saveFakeAdmins = onRequest(
    {
        region: "africa-south1"
    },
    async (req, res) => {
        // True means use online auth users, otherwise use emulator's.
        fakeAdmins.createFakeAdmin(true);
        res.json({ result: `Fake Admins Successfully Created.` });
    });

// http://127.0.0.1:5001/wow-we-won/africa-south1/createFakeActivationRequests
export const createFakeActivationRequests = onRequest(
    {
        region: "africa-south1"
    },
    async (req, res) => {

        // Durban Central Groupd
        let activationRequestReference = getFirestore().collection('activation_requests').doc();

        let activationRequest = {
            activationRequestId: activationRequestReference.id,
            approvedByAdminUserId: null,
            moneyCollectorFK: null,
            voucherType: 'OTT',
            requestDate: null,
            requestDateTimestamp: null,
            isApproved: null,
            isChecked: false,
            groupFK: '+27600000000',
            groupCreatorImageURL: 'durban central/group_members/+27600000000/profile_images/+27600000000.jpg',
            voucher: '12345678909876',
        };

        await activationRequestReference.set(activationRequest);


        activationRequestReference = getFirestore().collection('activation_requests').doc();

        activationRequest = {
            activationRequestId: activationRequestReference.id,
            approvedByAdminUserId: null,
            moneyCollectorFK: null,
            voucherType: '1Voucher',
            requestDate: null,
            requestDateTimestamp: null,
            isApproved: false,
            isChecked: false,
            groupFK: '+27610000000',
            groupCreatorImageURL: 'durban central/group_members/+27610000000/profile_images/+27610000000.jpg',
            voucher: '9892793839876',
        };

        await activationRequestReference.set(activationRequest);

        activationRequestReference = getFirestore().collection('activation_requests').doc();

        activationRequest = {
            activationRequestId: activationRequestReference.id,
            approvedByAdminUserId: null,
            moneyCollectorFK: null,
            voucherType: 'Blue Voucher',
            requestDate: null,
            requestDateTimestamp: null,
            isApproved: null,
            isChecked: false,
            groupFK: '+27620000000',
            groupCreatorImageURL: 'durban central/group_members/+27620000000/profile_images/+27620000000.jpg',
            voucher: '5342573848363846',
        };

        await activationRequestReference.set(activationRequest);

        res.json({ result: `Fake Activation Requests Successfully Created.` });

    }
);

// Create a function that replaces all the activation requests within groups by null.

// ########################################Development Functions [End]#######################################################


