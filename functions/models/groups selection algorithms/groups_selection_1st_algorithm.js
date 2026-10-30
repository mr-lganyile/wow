/* eslint-disable*/

class GroupsSelection1stAlgorithm {
    constructor(groupsSnapshot, groupToWinPhoneNumber, maxNumberOfGroupCompetitors) {
        this.groupsSnapshot = groupsSnapshot;
        this.groupToWinPhoneNumber = groupToWinPhoneNumber;
        this.maxNumberOfGroupCompetitors = maxNumberOfGroupCompetitors
    }

    shuffle(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    }


    createCompetitorsOrder() {

        let competitorsOrder = new Array();

        // Make sure all competitors are visited.
        this.groupsSnapshot.docs.forEach((groupDoc) => {
            if (!(groupDoc.id === this.groupToWinPhoneNumber)) {
                if (groupDoc.data()['isActive']) {
                    competitorsOrder.push(groupDoc.id);
                }

            }

        });

        // Make sure competitors are visited randomly.
        competitorsOrder = shuffle(competitorsOrder);

        if (this.groupsSnapshot.size > this.maxNumberOfGroupCompetitors) {
            let newCompetitorsList = [];
            for (let i = 0; i < this.maxNumberOfGroupCompetitors - 1; i++) {
                newCompetitorsList.push(competitorsOrder[i]);
            }
            newCompetitorsList.push(this.groupToWinPhoneNumber);
            competitorsOrder = newCompetitorsList;
        }
        else {

            competitorsOrder.push(this.groupToWinPhoneNumber);
        }


        return competitorsOrder;
    }
}

export default GroupsSelection1stAlgorithm