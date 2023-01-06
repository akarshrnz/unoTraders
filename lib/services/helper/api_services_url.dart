import '../../main.dart';

class ApiServicesUrl {
  //location
  static const String locationApiKey =
      "AIzaSyDNuI7bmvR7jew4NlQAc-cNXZfwmLxaqms";

  //Baseurl
  static const String baseUrl = 'https://demo.unotraders.com/api/v1/';
  static String id = sp!.getString('id')!;
  static String userType = sp!.getString('userType')!;
  //Auth
  static const String register = baseUrl + 'register';
  static const String checkUsername = baseUrl + 'check-username/';
  static const String login = baseUrl + 'login';
  static const String otpLogin = baseUrl + 'login-with-otp';
  static const String validateOtp = baseUrl + 'validate-otp';

  //Dashboard
  static const String banners = baseUrl + 'banners';
  static String profile = '${baseUrl}customer/profile/$id';
  static const String categories = baseUrl + 'categories';
  static const String subCategories = baseUrl + 'subcategories/';

  //trader
  static const String traderDetails = baseUrl + 'register';
  //bazaar
  static const String bazaarProduts = baseUrl + 'bazaar/';
  static const String bazaarCategories = baseUrl + 'bazaar-categories';
  static const String sellAtBazaar = baseUrl + 'bazaar/sell-at-bazaar';
  static const String shortListProduct = baseUrl + 'bazaar/shortlist-product';

  //job

  static const String currentJobDetails =
      'https://demo.unotraders.com/api/v1/job/editcustomerjob/';
  static const String postJob = baseUrl + 'jobs/post-job';
  static String jobStatus = baseUrl + 'job/status/${id}/';
  static const String customerSeekQuote = baseUrl + 'customer/seek-quote/';
  //Customer side job status
  static String customerJobAcceptReject =
      'https://demo.unotraders.com/api/v1/job/customerjobstatus/';
  static String customerJobOngoingCompleted =
      'https://demo.unotraders.com/api/v1/job/customerjobsprogress/';
  //trader side job status
  static String traderJobOngoingCompleted =
      'https://demo.unotraders.com/api/v1/job/traderjobsprogress/';
  static String traderJobAcceptReject =
      'https://demo.unotraders.com/api/v1/job/traderjobstatus/';
  //  static String traderOngoingCompleted =
  // 'https://demo.unotraders.com/api/v1/job/traderjobsprogress/';
  static String changeJobStatus =
      'https://demo.unotraders.com/api/v1/job/changejobstatus/';
  //wishList
  static const String wishList = baseUrl + 'customer/wishlist/';
  static const String addWishList = baseUrl + 'bazaar/shortlist-product';
  //profile
  static const String customerProfile = baseUrl + 'customer/profile/';
  static String updateCustomerProfile = baseUrl + 'customer/update-profile/$id';
  static String unPublishEndpoints = 'unpublish';
  static String postedEndpoints = 'published';
  static String completedEndpoints = 'completed';
  //endpoints job
  static const String publishedJob = 'published';
  static const String savedJob = 'Saved';
  static const String unpublishedJob = 'unpublished';
  static const String completedJob = 'completed';
  static const String acceptedJob = 'accepted';
  static const String rejectedJob = 'rejected';
  static const String ongoingJob = 'ongoing';
  static const String seekQuoteJob = "seek quote";

  //trader

  //profile
  static const String traderProfile = '${baseUrl}trader/profile/';
  static const String providerProfile = '${baseUrl}/subcategory/';

  //list all trder req in customer panel
  static const String tradersQuoteReq =
      'https://demo.unotraders.com/api/v1/job/jobquote/';
}
