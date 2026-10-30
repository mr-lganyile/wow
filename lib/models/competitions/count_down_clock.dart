// Branch : competition_resources_crud ->  create_competition_resources_front_end
class CountDownClock {
  int remainingTime;

  CountDownClock({
    required this.remainingTime,
  });

  factory CountDownClock.fromJson(dynamic json) => CountDownClock(
        remainingTime: json["remainingTime"],
      );
}
