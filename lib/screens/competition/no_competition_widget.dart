import 'package:flutter/material.dart';

import '../hosting area/hosting_area_widget.dart';

// Branch : competition_resources_crud ->  view_competitions
class NoCompetitionWidget extends HostingAreaWidget {
  NoCompetitionWidget({
    super.key,
    required hostingAreaId,
    required hostingAreaName,
    required hostingAreaImageURL,
    required sectionName,
  }) : super(
         hostingAreaId: hostingAreaId,
         hostingAreaName: hostingAreaName,
         hostingAreaImageURL: hostingAreaImageURL,
         sectionName: sectionName,
       );

  @override
  State createState() => NoCompetitionWidgetState();
}

class NoCompetitionWidgetState extends State<NoCompetitionWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Competition',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }
}
