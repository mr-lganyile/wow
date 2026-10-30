/* eslint-disable*/

class GroupsSelection2ndAlgorithm {
    constructor(groupsSnapshot, groupToWinPhoneNumber) {
        this.groupsSnapshot = groupsSnapshot;
        this.groupToWinPhoneNumber = groupToWinPhoneNumber;
    }

    shuffle(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    }


    createCompetitorsOrder() {

        // Group objects
        let allCompetitingGroups = new Array();
        // Key: section name Value: group creator phone number
        const selectedCompitingGroups = new Map();

        // Make sure all competitors are visited.
        this.groupsSnapshot.docs.forEach((groupDoc) => {
            if (!(groupDoc.id === this.groupToWinPhoneNumber)) {
                if (groupDoc.data()['isActive']) {
                    allCompetitingGroups.push(groupDoc.data());

                }

            }

        });

        // Make sure competitors are visited randomly.
        allCompetitingGroups = shuffle(allCompetitingGroups);

        for (let i = 0; i < allCompetitingGroups.length; i++) {
            selectedCompitingGroups.set(
                allCompetitingGroups[i].groupArea['areaName'],
                allCompetitingGroups[i].groupCreatorPhoneNumber);
        }

        // Convert map values into an array.
        const competitorsOrder = Array.from(selectedCompitingGroups.values);
        competitorsOrder.push(this.groupToWinPhoneNumber);

        return competitorsOrder;
    }
}

export default GroupsSelection2ndAlgorithm