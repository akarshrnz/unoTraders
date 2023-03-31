class ProfileInsightsModel {
  int? searchHistory;
  int? profileVisits;
  int? contacted;
  int? jobQuoteCount;
  JobCount? jobCount;

  ProfileInsightsModel(
      {this.searchHistory,
      this.profileVisits,
      this.contacted,
      this.jobQuoteCount,
      this.jobCount});

  ProfileInsightsModel.fromJson(Map<String, dynamic> json) {
    searchHistory = json['search_history'];
    profileVisits = json['profile_visits'];
    contacted = json['contacted'];
    jobQuoteCount = json['job_quote_count'];
    jobCount = json['job_count'] != null
        ? new JobCount.fromJson(json['job_count'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search_history'] = searchHistory;
    data['profile_visits'] = profileVisits;
    data['contacted'] = contacted;
    data['job_quote_count'] = jobQuoteCount;
    if (jobCount != null) {
      data['job_count'] = jobCount!.toJson();
    }
    return data;
  }
}

class JobCount {
  int? ongoing;
  int? accepted;
  int? rejected;
  int? completed;

  JobCount({this.ongoing, this.accepted, this.rejected, this.completed});

  JobCount.fromJson(Map<String, dynamic> json) {
    ongoing = json['ongoing'];
    accepted = json['accepted'];
    rejected = json['rejected'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ongoing'] = ongoing;
    data['accepted'] = accepted;
    data['rejected'] = rejected;
    data['completed'] = completed;
    return data;
  }
}
