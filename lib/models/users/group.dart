// Collection Name /groups
// Has Unit Tests
import '/models/competitions/activation_request.dart';

import '../locations/supported_area.dart';
import '../locations/supported_town_or_institution.dart';

class Group implements Comparable<Group> {
  String groupId;
  String groupName;

  String groupImageURL;

  SupportedTownOrInstitution groupTownOrInstitution;

  SupportedArea groupArea;
  String? groupSpecificArea;

  String groupCreatorPhoneNumber;

  String groupCreatorImageURL;

  String groupCreatorUsername;

  bool isActive; // A group is active if it has atleast 10 members.

  int maxNoOfMembers; // 5

  List<String> groupMembers;
  List<String> get members => groupMembers;
  double availableBalance;

  ActivationRequest? activationRequest;

  String? groupRegisteryAdminId;

  Group({
    required this.groupId,
    required this.groupName,
    this.groupRegisteryAdminId,
    required this.groupImageURL,
    required this.groupTownOrInstitution,
    required this.groupArea,
    this.groupSpecificArea, // Add required when new emulator data is inserted
    required this.groupCreatorPhoneNumber,
    required this.groupCreatorImageURL,
    required this.groupCreatorUsername,
    required this.groupMembers,
    this.isActive = false,
    required this.maxNoOfMembers,
    this.availableBalance = 0,
    this.activationRequest,
  });

  Map<String, dynamic> toJson() => {
    'groupId': groupId,
    'groupName': groupName,
    'groupRegisteryAdminId': groupRegisteryAdminId,
    'groupImageURL': groupImageURL,
    'groupCreatorPhoneNumber': groupCreatorPhoneNumber,
    'groupTownOrInstitution': groupTownOrInstitution.toJson(),
    'groupArea': groupArea.toJson(),
    'groupCreatorUsername': groupCreatorUsername,
    'groupCreatorImageURL': groupCreatorImageURL,
    'groupMembers': groupMembers,
    'isActive': isActive,
    'maxNoOfMembers': maxNoOfMembers,
    'groupSpecificArea': groupSpecificArea,
    'availableBalance': availableBalance,
    'activationRequest': null,
  };

  factory Group.fromJson(dynamic json) => Group(
    groupId: json['groupId'],
    groupName: json['groupName'],
    groupRegisteryAdminId: json['groupRegisteryAdminId'],
    groupImageURL: json['groupImageURL'],
    groupTownOrInstitution: SupportedTownOrInstitution.fromJson(
      json['groupTownOrInstitution'],
    ),
    groupArea: SupportedArea.fromJson(json['groupArea']),
    groupSpecificArea:
        // ignore: prefer_if_null_operators
        json['groupSpecificArea'] != null ? json['groupSpecificArea'] : null,
    groupCreatorPhoneNumber: json['groupCreatorPhoneNumber'],
    groupCreatorImageURL: json['groupCreatorImageURL'],
    groupMembers: toListOfStrings(json['groupMembers']),
    isActive: json['isActive'],
    maxNoOfMembers: json['maxNoOfMembers'],
    activationRequest: json['activationRequest'] != null
        ? ActivationRequest.fromJson(json['activationRequest'])
        : null,
    groupCreatorUsername: json['groupCreatorUsername'],
  );

  @override
  int compareTo(Group other) {
    return groupArea.compareTo(other.groupArea);
  }

  @override
  String toString() {
    return groupName + '\t' + groupImageURL;
  }

  // For Learning Unit Testing Purpose.
  bool removeMember(String memberPhoneNumber) {
    if (memberPhoneNumber.compareTo(groupCreatorPhoneNumber) != 0 &&
        groupMembers.length > 1 &&
        groupMembers.contains(memberPhoneNumber)) {
      groupMembers.remove(memberPhoneNumber);
      return true;
    } else {
      return false;
    }
  }

  // For Learning Unit Testing Purpose.
  bool addMember(String memberPhoneNumber) {
    if (memberPhoneNumber.compareTo(groupCreatorPhoneNumber) != 0 &&
        groupMembers.length < maxNoOfMembers &&
        !groupMembers.contains(memberPhoneNumber)) {
      groupMembers.add(memberPhoneNumber);
      return true;
    } else {
      return false;
    }
  }
}

List<String> toListOfStrings(List<dynamic> members) {
  List<String> list = [];

  for (int i = 0; i < members.length; i++) {
    list.add(members[i].toString());
  }
  return list;
}
