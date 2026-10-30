/* Collection Name /competition/competitionId
/competitors_grids*/

// Competition & CompetitorGrid Have Similar IDs
// Branch : competition_resources_crud ->  create_competition_resources_front_end
class GroupCompetitorsGrid {
  String competitorsGridId;
  String competitionFK;
  int numberOfCompetitors;
  int currentlyPointedTokenIndex;

  // The order in which participants were visited when this competition was live.
  // This property is used for the sake of viewing competitions which have already played.
  List<int> competitorsOrder;

  // Contain a sub collection of competition tokens.

  Duration duration;
  bool? hasStarted;
  bool? hasStopped;

  GroupCompetitorsGrid({
    required this.competitorsGridId,
    required this.competitionFK,
    required this.numberOfCompetitors,
    required this.currentlyPointedTokenIndex,
    required this.competitorsOrder,
    required this.duration,
    this.hasStarted = false,
    this.hasStopped = false,
  });

  factory GroupCompetitorsGrid.fromJson(dynamic json) {
    return GroupCompetitorsGrid(
      competitorsGridId: json['competitorsGridId'],
      competitionFK: json['competitionFK'],
      numberOfCompetitors: json['numberOfCompetitors'],
      currentlyPointedTokenIndex: json['currentlyPointedTokenIndex'],
      competitorsOrder: json['competitorsOrder'],
      duration: Duration(seconds: json['duration']),
      hasStarted: json['hasStarted'],
      hasStopped: json['hasStopped'],
    );
  }
}
