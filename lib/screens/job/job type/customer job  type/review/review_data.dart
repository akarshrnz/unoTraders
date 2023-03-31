class ReviewData {
  static List<String> review = [
    "Very Bad",
    "Bad",
    "Average",
    "Good",
    "very good",
  ];
  static List<String> reviewQuestions = ["Yes", "No"];

  static int reviewValues({required String reviewtype}) {
    if (reviewtype == review[0]) {
      return 0;
    } else if (reviewtype == review[1]) {
      return 1;
    } else if (reviewtype == review[2]) {
      return 2;
    } else if (reviewtype == review[3]) {
      return 3;
    } else {
      return 4;
    }
  }

  static int reviewQuestionsValues({required String reviewtype}) {
    if (reviewtype == reviewQuestions[0]) {
      return 0;
    } else {
      return 1;
    }
  }
}
