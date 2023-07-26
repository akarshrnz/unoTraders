import 'package:codecarrots_unotraders/screens/Bazaar/bazaar_screen.dart';
import 'package:codecarrots_unotraders/screens/dashboard/dashboard.dart';

import 'package:codecarrots_unotraders/screens/homepage/new_home.dart';

import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_accepted_job.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_completed_job.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_completed_job.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_ongoing.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_all_jobs.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_accept.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_reject.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_live_job.dart';
import 'package:codecarrots_unotraders/screens/job/customer%20job%20screen/post_job.dart';

import 'package:codecarrots_unotraders/screens/job/job%20type/trader%20job%20type/trader_rejected_job.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/seeking_quote_job.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/customer_unpublished_job.dart';
import 'package:codecarrots_unotraders/screens/job/job%20type/customer%20job%20%20type/drafted_job.dart';
import 'package:codecarrots_unotraders/screens/appointments/appointment_listing.dart';
import 'package:flutter/material.dart';

import '../screens/job/job type/trader job type/trader_ongoing_job.dart';

class RouterClass {
  static const String dashboard = '/dashBoard';
  static const String home = '/homeScreen';
  static const String postJob = '/postJob';
  static const String liveJob = '/liveJob';
  static const String allJob = '/allJob';
  static const String bazaarScreen = '/bazaarscreen';
  static const String savedJob = '/unPublished';
  static const String completedJob = '/completedjob';
  static const String unPublishedJob = '/unPublishedJob';
  static const String rejectedJob = '/rejectedJob';
  static const String ongoingJob = '/ongoingJob';
  static const String customerOngoingJob = '/customerOngoingJob';
  static const String customerCompletedJob = '/customercompletedJob';
  static const String acceptedJob = '/acceptedJob';
  static const String customerAcceptedJob = '/customerAcceptedJob';
  static const String customerRejectedJob = '/customerRejectedJob';
  static const String seekQuteJob = '/seekQuteJob';
  static const String appointments = '/appointments';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case appointments:
        return MaterialPageRoute(builder: (_) => const AppointmentListing());

      case unPublishedJob:
        return MaterialPageRoute(builder: (_) => const UnPublishedJob());
      case customerAcceptedJob:
        return MaterialPageRoute(builder: (_) => const CustomerAccept());
      case customerRejectedJob:
        return MaterialPageRoute(builder: (_) => const CustomerReject());
      case savedJob:
        return MaterialPageRoute(builder: (_) => const SavedJob());
      case allJob:
        return MaterialPageRoute(builder: (_) => const AllJobs());
      case completedJob:
        return MaterialPageRoute(builder: (_) => const Completedjob());
      case customerCompletedJob:
        return MaterialPageRoute(builder: (_) => const CustomerCompleted());
      case rejectedJob:
        return MaterialPageRoute(builder: (_) => const RejectedJob());
      case seekQuteJob:
        return MaterialPageRoute(builder: (_) => const SeekingQuoteJob());
      case ongoingJob:
        return MaterialPageRoute(builder: (_) => TraderOngoingJob());
      case customerOngoingJob:
        return MaterialPageRoute(builder: (_) => const CustomerOngoingjob());
      case acceptedJob:
        return MaterialPageRoute(builder: (_) => const AcceptedJob());

      case home:
        return MaterialPageRoute(builder: (_) => const NewHomePage());
      case liveJob:
        return MaterialPageRoute(builder: (_) => const CustomerLiveJob());
      case postJob:
        return MaterialPageRoute(builder: (_) => const PostJob());
      case bazaarScreen:
        return MaterialPageRoute(builder: (_) => const BazaarScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
