import 'package:flutter/material.dart';

// Branch : won_price_summary_resources_crud -> view_won_price_summaries
class CompetitionFinishedWidget extends StatefulWidget {
  DateTime endMoment;
  CompetitionFinishedWidget({
    super.key,
    required this.endMoment,
  });

  @override
  State createState() => CompetitionFinishedWidgetState();
}

class CompetitionFinishedWidgetState extends State<CompetitionFinishedWidget> {
  @override
  Widget build(BuildContext context) {
    String fullEndDateTime = widget.endMoment
        .toLocal()
        .toString()
        .substring(0, widget.endMoment.toLocal().toString().length - 4);
    List<String> dateAndTime = fullEndDateTime.split(' ');
    String date = dateAndTime[0];
    String time = dateAndTime[1];

    String switchDateTimeFormat() {
      List<String> oldDateFormat = date.split('-');
      String month;

      List<String> oldTimeFormat = time.split(':');
      int monthNumber = int.parse(oldDateFormat[1]);

      switch (monthNumber) {
        case 1:
          month = "Jan";
          break;
        case 2:
          month = "Feb";
          break;
        case 3:
          month = "Mar";
          break;
        case 4:
          month = "Apr";
          break;
        case 5:
          month = "May";
          break;
        case 6:
          month = "Jun";
          break;
        case 7:
          month = "Jul";
          break;
        case 8:
          month = "Aug";
          break;
        case 9:
          month = "Sep";
          break;
        case 10:
          month = "Oct";
          break;
        case 11:
          month = "Nov";
          break;
        default:
          month = "Dec";
      }

      return '${oldDateFormat[2]} $month ${oldDateFormat[0]} @ ${oldTimeFormat[0]}:${oldTimeFormat[1]}';
    }

    return Center(
      child: Column(
        children: [
          const Text(
            'Competition Finished',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          const Text(
            'On',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          Text(
            switchDateTimeFormat(),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
        ],
      ),
    );
  }
}
