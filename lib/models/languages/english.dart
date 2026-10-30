import '/models/languages/language.dart';

class English extends Language {
  @override
  String translateAnswerOneQuestionOnly() {
    return 'Answer 1 Question By Text, Image Or Video.';
  }

  @override
  String translateImageAsAnswer() {
    return 'Answer With Image';
  }

  @override
  String translateImageMax10MB() {
    return 'Max 10MB';
  }

  @override
  String translateNoSwearing() {
    return 'No Swearing';
  }

  @override
  String translateTextAsAnswer() {
    return 'Answer With Text';
  }

  @override
  String translateVideoAsAnswer() {
    return 'Answer With Video';
  }

  @override
  String translateVideoMax10Seconds() {
    return 'Max 10 Seconds';
  }

  @override
  String translateWhatFlopDidHeOrSheDoWhenHeWasDrunk() {
    return 'What Alcohol Flop Did He/She Do?';
  }

  @override
  String translateWhereWasIDrinking() {
    return 'Where Was I Drinking?';
  }

  @override
  String translateWhereWereYouDrinking() {
    return 'Where Were You Drinking?';
  }

  @override
  String translateWhoWasDrinkingWithMe() {
    return 'Who Was Drinking With Me?';
  }

  @override
  String translateWhoWereYouDrinkingWith() {
    return 'Who Were You Drinking With?';
  }

  @override
  String translateWhatWereYouDrinking() {
    return 'What Were You Drinking?';
  }

  @override
  String translateWhatWasIDrinking() {
    return 'What Was I Drinking?';
  }
}
