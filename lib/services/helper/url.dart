import '../../main.dart';

class Url {
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
  static String profile = '${baseUrl}customer/profile/';
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
  static const String updatePostedJob = baseUrl + 'job/updatecustomerjob';
  static String jobStatus = baseUrl + 'job/status';
  // static String jobStatu = baseUrl + 'job/status/${id}/';
  static const String customerSeekQuote = baseUrl + 'customer/seek-quote/';
  static const String customerGetQuote = baseUrl + 'job/getquote';

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
  // static String updateCustomerProfile = baseUrl + 'customer/update-profile/$id';
  static String unPublishEndpoints = 'unpublish';
  static String postedEndpoints = 'published';
  static String completedEndpoints = 'completed';
  static String postJobEndpoints = 'postjob';
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
  static const String traderProfile = '${baseUrl}trader/profile';
  static const String providerProfile = '${baseUrl}/subcategory/';

  //comment
  static const String getPostedComment =
      'https://demo.unotraders.com/api/v1/traderpostcomments/';
  static const String getOfferComment =
      'https://demo.unotraders.com/api/v1/traderoffercomments/';
  static const String postFeedReplyComment =
      'https://demo.unotraders.com/api/v1/commentreply';
  static const String postOfferReplyComment =
      'https://demo.unotraders.com/api/v1/offercommentreply';
  static const String postFeedComment =
      'https://demo.unotraders.com/api/v1/postcomment';
  static const String postOfferComment =
      'https://demo.unotraders.com/api/v1/offercomment';

  //list all trder req in customer panel
  static const String tradersQuoteReq =
      'https://demo.unotraders.com/api/v1/job/jobquote/';

  //message
  static const String messageList = baseUrl + "message/userlist";
  static const String sendMessage = baseUrl + "message/storemessage";
  static const String getOneToOneMessage = baseUrl + "message/getmessages";
  static const String storeBazaarMessage =
      baseUrl + "message/bazaarstoremessage";
  //notification
  static const String notification = baseUrl + "getnotifications/";

  //add review in textfield by visit profile

  static const String addMainReviewComment =
      baseUrl + "trader/addreviewcomment";
  static const String addReplyReviewComment =
      baseUrl + "trader/addreviewcommentreply";

  //profile isights
  static const String profileInsights = baseUrl + "profileinsights";
  static const String getProfileVisitors = baseUrl + "profilevisitors";
  static const String getCustomerscontacted = baseUrl + "customerscontacted";
  static const String getSearchhistory = baseUrl + "searchhistory";
  static const String getBlockedTraders = baseUrl + "customer/blocked-traders/";
  static const String blockUnBlockTraders = baseUrl + "blockuser";
}
