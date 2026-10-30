/* eslint-disable*/
class Competition {
    constructor(
        competitionId,
        storeFK,
        townOrInstitution,
        dateTime,
        joiningFee,
        numberOfGrandPrices,
        pickingMultipleInSeconds,
        timeBetweenPricePickingAndGroupPicking,
        displayPeriodAfterWinners
    ) {
        this.competitionId = competitionId,
            this.storeFK = storeFK,
            this.townOrInstitution = townOrInstitution,
            this.isLive = true,
            this.dateTime = dateTime,
            this.joiningFee = joiningFee,
            this.numberOfGrandPrices = numberOfGrandPrices,
            this.isOver = false,
            this.grandPricesGridId = "-",
            this.competitorsGridId = "-",
            this.groupPickingStartTime = -1,
            this.pickingMultipleInSeconds = pickingMultipleInSeconds,
            this.timeBetweenPricePickingAndGroupPicking = timeBetweenPricePickingAndGroupPicking,
            this.displayPeriodAfterWinners = displayPeriodAfterWinners, // must switch to 5 minute (300)

            this.grandPricesOrder = [],
            this.isWonGrandPricePicked = false,
            this.competitorsOrder = [],
            this.isWonCompetitorGroupPicked = false,
            this.competitionState = "on-count-down",
            this.wonPrice = null,
            this.wonGroup = null
    }

    toJson() {
        return {
            competitionId: this.competitionId,
            storeFK: this.storeFK,
            townOrInstitution: this.townOrInstitution,
            isLive: this.isLive,
            dateTime: this.dateTime,
            joiningFee: this.joiningFee,
            numberOfGrandPrices: this.numberOfGrandPrices,
            isOver: this.isOver,
            grandPricesGridId: this.grandPricesGridId,
            competitorsGridId: this.competitorsGridId,
            groupPickingStartTime: this.groupPickingStartTime,
            pickingMultipleInSeconds: this.pickingMultipleInSeconds,
            timeBetweenPricePickingAndGroupPicking: this.timeBetweenPricePickingAndGroupPicking,
            displayPeriodAfterWinners: this.displayPeriodAfterWinners, // must switch to 5 minute (300)

            grandPricesOrder: this.grandPricesOrder,
            isWonGrandPricePicked: this.isWonGrandPricePicked,
            competitorsOrder: this.competitorsOrder,
            isWonCompetitorGroupPicked: this.isWonCompetitorGroupPicked,
            competitionState: this.competitionState,
            wonPrice: this.wonPrice.toJson(),
            wonGroup: this.wonGroup.toJson(),

        };
    }


}