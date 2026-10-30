/* Collection Name /competition/competitionId
/grand_prices_grids/grandPriceGridId
/grand_prices_tokens*/

// Competition & CompetitorGrid Have Similar IDs
import '../hosting areas/draw_grand_price.dart';

// Branch : competition_resources_crud ->  create_competition_resources_front_end
class GrandPriceToken {
  String grandPriceTokenId;
  String grandPricesGridFK;
  int tokenIndex;
  //bool isPointed;
  String imageURL;
  String description;

  GrandPriceToken({
    required this.grandPriceTokenId,
    required this.grandPricesGridFK,
    required this.tokenIndex,
    //required this.isPointed,
    required this.imageURL,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'grandPriceTokenId': grandPriceTokenId,
      'grandPricesGridFK': grandPricesGridFK,
      'tokenIndex': tokenIndex,
      //'isPointed': isPointed,
      'imageURL': imageURL,
      'description': description,
    });
    return map;
  }

  factory GrandPriceToken.fromJson(dynamic json) {
    return GrandPriceToken(
        grandPriceTokenId: json['grandPriceTokenId'],
        grandPricesGridFK: json['grandPricesGridFK'],
        tokenIndex: json['tokenIndex'],
        //isPointed: json['isPointed'],
        imageURL: json['imageURL'],
        description: json['description']);
  }

  factory GrandPriceToken.fromDrawGrandPrice(DrawGrandPrice drawGrandPrice) {
    return GrandPriceToken(
        grandPriceTokenId: drawGrandPrice.grandPriceId!,
        grandPricesGridFK: drawGrandPrice.hostedDrawFK!,
        tokenIndex: drawGrandPrice.grandPriceIndex,
        //isPointed: false,
        imageURL: '',
        description: drawGrandPrice.description);
  }
}
