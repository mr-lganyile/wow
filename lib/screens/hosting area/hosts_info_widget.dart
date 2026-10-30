import 'dart:developer' as debug;

import '../utils/globals.dart';
import '../../controllers/hosting_area_controller.dart';
import 'host_info_widget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

import '../../models/hosting areas/host_info.dart';

// Branch : store_resources_crud ->  view_stores_front_end
class HostsInfoWidget extends StatefulWidget {
  HostsInfoWidget({
    super.key,
  });

  @override
  HostsInfoWidgetState createState() => HostsInfoWidgetState();
}

// Firstly start by reading the documents of StoreNameInfo Collection.
class HostsInfoWidgetState extends State<HostsInfoWidget> {
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;
  late Stream<List<HostInfo>> hostsInfoStream;
  late List<HostInfo> hostsInfo;

  @override
  void initState() {
    super.initState();

    hostsInfoStream = hostingAreaController.readAllHostInfo();
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: MyApplication.scaffoldColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: MyApplication.storeDataPadding,
          child: StreamBuilder<List<HostInfo>>(
            stream: hostsInfoStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                hostsInfo = snapshot.data!;
                hostsInfo.sort();

                return ListView.builder(
                    itemCount: hostsInfo.length,
                    itemBuilder: ((context, index) {
                      HostInfo hostInfo = hostsInfo[index];
                      return HostInfoWidget(hostInfo: hostInfo);
                    }));
              } else if (snapshot.hasError) {
                debug.log(
                    "Error Fetching All Host Info Data - ${snapshot.error}");
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            },
          ),
        ),
      );
}
