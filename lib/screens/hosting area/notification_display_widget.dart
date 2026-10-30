import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/hosting areas/notification.dart' as not;

class NotificationDisplayWidget extends StatelessWidget {
  not.Notification notification;

  NotificationDisplayWidget({required this.notification});

  @override
  Widget build(BuildContext context) => Center(
        child: Card(
          color: Colors.black.withBlue(30),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              notification.message,
              style:
                  TextStyle(fontSize: 16, color: MyApplication.storesTextColor),
            ),
          ),
        ),
      );
}
