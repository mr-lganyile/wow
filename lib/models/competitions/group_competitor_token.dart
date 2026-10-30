import '../users/group.dart';

/* Collection Name /competition/competitionId
/competitors_grids/competitorsGridId
/competitor_tokens*/
// Branch : competition_resources_crud ->  create_competition_resources_front_end
class GroupCompetitorToken {
  String groupCompetitorTokenId;
  String groupCompetitorsGridFK;
  int tokenIndex;
  bool isPointed;
  Group group;

  GroupCompetitorToken({
    required this.groupCompetitorTokenId,
    required this.groupCompetitorsGridFK,
    required this.tokenIndex,
    required this.isPointed,
    required this.group,
  });

  factory GroupCompetitorToken.fromJson(dynamic json) {
    return GroupCompetitorToken(
      groupCompetitorTokenId: json['groupCompetitorTokenId'],
      groupCompetitorsGridFK: json['groupCompetitorsGridFK'],
      tokenIndex: json['tokenIndex'],
      isPointed: json['isPointed'],
      group: Group.fromJson(json['group']),
    );
  }
}
