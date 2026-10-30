// Collection Name /competition/competitionId/grand_prices_grids

// Competition & CompetitorGrid Have Similar IDs
// Branch : competition_resources_crud ->  create_competition_resources_front_end
class GrandPricesGrid {
  String grandPricesGridId;
  String competitionFK;
  int numberOfGrandPrices;
  int currentlyPointedTokenIndex;

  // The order in which grand prices were visited when this competition was live.
  // This property is used for the sake of viewing competitons which have already played.
  List<int> grandPricesOrder;

  // Contain a sub collection of grand prices tokens.

  Duration duration;
  bool? hasStarted;
  bool? hasStopped;

  GrandPricesGrid({
    required this.grandPricesGridId,
    required this.competitionFK,
    required this.numberOfGrandPrices,
    required this.currentlyPointedTokenIndex,
    required this.grandPricesOrder,
    required this.duration,
    this.hasStarted = false,
    this.hasStopped = false,
  });

  factory GrandPricesGrid.fromJson(dynamic json) {
    return GrandPricesGrid(
        grandPricesGridId: json['grandPricesGridId'],
        competitionFK: json['competitionFK'],
        numberOfGrandPrices: json['numberOfGrandPrices'],
        currentlyPointedTokenIndex: json['currentlyPointedTokenIndex'],
        grandPricesOrder: convert(json['grandPricesOrder']),
        duration: Duration(seconds: json['duration']),
        hasStarted: json['hasStarted'],
        hasStopped: json['hasStopped']);
  }

  static List<int> convert(List<dynamic> list) {
    List<int> newList = [];

    for (int i = 0; i < list.length; i++) {
      newList.add(list[i] as int);
    }

    return newList;
  }
}
