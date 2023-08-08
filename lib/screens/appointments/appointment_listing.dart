import 'package:codecarrots_unotraders/model/appointments/change_appoint_status_model.dart';
import 'package:codecarrots_unotraders/model/appointments/get_customer_appointment_model.dart';
import 'package:codecarrots_unotraders/model/appointments/get_trader_appointmenys-modl.dart';
import 'package:codecarrots_unotraders/model/appointments/reshedule_model.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/screens/widgets/default_button.dart';
import 'package:codecarrots_unotraders/services/profile_services.dart';
import 'package:codecarrots_unotraders/utils/color.dart';
import 'package:codecarrots_unotraders/utils/app_constant_widgets.dart';
import 'package:codecarrots_unotraders/utils/png.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentListing extends StatefulWidget {
  const AppointmentListing({super.key});

  @override
  State<AppointmentListing> createState() => _TraderAppointmentsListingState();
}

class _TraderAppointmentsListingState extends State<AppointmentListing> {
  late ProfileProvider profileProvider;
  DateTime? validFrom;
  DateTime dateTime = DateTime.now();
  DateTime? validTo;

  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.dispose();
    });

    super.initState();
  }

  @override
  void dispose() {
    profileProvider.isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(PngImages.arrowBack)),
        centerTitle: true,
        title: const Text(
          'Appointments',
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: Consumer<CurrentUserProvider>(
          builder: (context, currentUserProvider, _) {
        return Consumer<ProfileProvider>(builder: (context, provider, _) {
          return provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : currentUserProvider.currentUserType == "customer"
                  ? customerScreen(size)
                  : traderScreen(size);
        });
      }),
    );
  }

  Padding traderScreen(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .03, vertical: size.width * .01),
      child: FutureBuilder<List<GetTraderAppointmentModel>>(
          future: ProfileServices.getTraderAppointments(),
          builder: (context,
              AsyncSnapshot<List<GetTraderAppointmentModel>> snapshot) {
            List<GetTraderAppointmentModel>? appointmentsList = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (snapshot.hasData) {
                return traderAppointments(size, snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return traderAppointments(size, snapshot.data);
              } else {
                const Center(child: Text("Document does not exist"));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: CircularProgressIndicator());

            // return Column(children: [
            //  ListView.separated(itemBuilder: (context, index) {

            //  }, separatorBuilder: (context, index) => Constant.kheight(height: size.width*.02), itemCount: 5)
            // ],);
          }),
    );
  }

  Widget traderAppointments(Size size, List<GetTraderAppointmentModel>? data) {
    return data == null
        ? const SizedBox()
        : Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final appointment = data[index];

                    final format24 = DateFormat.Hm(); // create a 24-hour format
                    final dateTime = format24.parse(
                        appointment.appointmentTime ??
                            ""); // parse the time string to DateTime
                    final format12 =
                        DateFormat('h:mm a'); // create a 12-hour format
                    final time12 = format12.format(dateTime);
                    return Card(
                      elevation: .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppConstant.kWidth(width: size.width * .018),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  NetworkImage(appointment.profilePic ?? ""),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          AppConstant.kWidth(width: size.width * .018),
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppConstant.kheight(height: size.width * .01),
                                Text(appointment.name ?? "",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19)),
                                Row(
                                  children: [
                                    Expanded(
                                        child: RichText(
                                      text: TextSpan(
                                          text:
                                              "Date ${appointment.appointmentDate} $time12 ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                          children: [
                                            TextSpan(
                                                text: '\nStatus ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18)),
                                            TextSpan(
                                              text: appointment.status,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 18),
                                            ),
                                          ]),
                                    ))
                                  ],
                                ),
                                appointment.status == null
                                    ? SizedBox()
                                    : appointment.status == "Rescheduled" ||
                                            appointment.status!.toLowerCase ==
                                                "Cancelled" ||
                                            appointment.status == "Booked"
                                        ? Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: DefaultButton(
                                                    textColor:
                                                        AppColor.blackColor,
                                                    backgroundColor:
                                                        AppColor.whiteColor,
                                                    height: 30,
                                                    text: "Accept",
                                                    onPress: () async {
                                                      ChangeAppointmentStatusModel
                                                          changeModel =
                                                          ChangeAppointmentStatusModel(
                                                              remarks: "thanks",
                                                              appointmentId:
                                                                  appointment
                                                                      .id,
                                                              status:
                                                                  "Accepted");
                                                      bool res = await profileProvider
                                                          .changeAppointmentStatus(
                                                              status:
                                                                  changeModel);
                                                      if (res == true) {
                                                        setState(() {});
                                                      } else {}
                                                    },
                                                    borderSide: BorderSide(
                                                        color: AppColor.green),
                                                    radius: 20),
                                              ),
                                              AppConstant.kWidth(
                                                  width: size.width * .01),
                                              Expanded(
                                                flex: 1,
                                                child: DefaultButton(
                                                    textColor:
                                                        AppColor.blackColor,
                                                    backgroundColor:
                                                        AppColor.whiteColor,
                                                    height: 30,
                                                    text: "Reject",
                                                    onPress: () async {
                                                      ChangeAppointmentStatusModel
                                                          changeModel =
                                                          ChangeAppointmentStatusModel(
                                                              remarks: "thanks",
                                                              appointmentId:
                                                                  appointment
                                                                      .id,
                                                              status:
                                                                  "Rejected");
                                                      bool res = await profileProvider
                                                          .changeAppointmentStatus(
                                                              status:
                                                                  changeModel);
                                                      if (res == true) {
                                                        setState(() {});
                                                      } else {}
                                                    },
                                                    borderSide: BorderSide(
                                                        color: AppColor.red),
                                                    radius: 20),
                                              ),
                                              AppConstant.kWidth(
                                                  width: size.width * .01),
                                              Expanded(
                                                flex: 1,
                                                child: DefaultButton(
                                                    backgroundColor:
                                                        AppColor.whiteColor,
                                                    height: 30,
                                                    text: "Cancel",
                                                    textColor:
                                                        AppColor.blackColor,
                                                    onPress: () async {
                                                      ChangeAppointmentStatusModel
                                                          changeModel =
                                                          ChangeAppointmentStatusModel(
                                                              remarks: "thanks",
                                                              appointmentId:
                                                                  appointment
                                                                      .id,
                                                              status:
                                                                  "Cancelled");
                                                      bool res = await profileProvider
                                                          .changeAppointmentStatus(
                                                              status:
                                                                  changeModel);
                                                      if (res == true) {
                                                        setState(() {});
                                                      } else {}
                                                    },
                                                    borderSide: BorderSide(
                                                        color: AppColor
                                                            .blackColor),
                                                    radius: 20),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(""),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                appointment.status == null
                                    ? AppConstant.kheight(
                                        height: size.width * .04)
                                    : appointment.status == "Rescheduled" ||
                                            appointment.status!.toLowerCase ==
                                                "Cancelled" ||
                                            appointment.status == "Booked"
                                        ? AppConstant.kheight(
                                            height: size.width * .004)
                                        : AppConstant.kheight(
                                            height: size.width * .04),
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      AppConstant.kheight(height: size.width * .01),
                  itemCount: data.length)
            ],
          );
  }

  Padding customerScreen(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .03, vertical: size.width * .01),
      child: FutureBuilder<List<GetCustomerAppointmentsModel>>(
          future: ProfileServices.getCustomerAppointments(),
          builder: (context,
              AsyncSnapshot<List<GetCustomerAppointmentsModel>> snapshot) {
            List<GetCustomerAppointmentsModel>? appointmentsList =
                snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (snapshot.hasData) {
                return customerAppointments(size, appointmentsList);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return customerAppointments(size, appointmentsList);
              } else {
                const Center(child: Text("Document does not exist"));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: CircularProgressIndicator());

            // return Column(children: [
            //  ListView.separated(itemBuilder: (context, index) {

            //  }, separatorBuilder: (context, index) => Constant.kheight(height: size.width*.02), itemCount: 5)
            // ],);
          }),
    );
  }

  Widget customerAppointments(
      Size size, List<GetCustomerAppointmentsModel>? data) {
    return data == null
        ? const SizedBox()
        : Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final appointment = data[index];
                    return Card(
                      elevation: .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppConstant.kWidth(width: size.width * .018),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  NetworkImage(appointment.image ?? ""),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          AppConstant.kWidth(width: size.width * .018),
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppConstant.kheight(height: size.width * .01),
                                Text(appointment.name ?? "",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19)),
                                Row(
                                  children: [
                                    Expanded(
                                        child: RichText(
                                      text: TextSpan(
                                          text:
                                              "Date ${appointment.appointmentDate}  ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                          children: [
                                            TextSpan(
                                                text: 'Status ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18)),
                                            TextSpan(
                                              text: appointment.status,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 18),
                                            ),
                                          ]),
                                    ))
                                  ],
                                ),
                                appointment.status == "Cancelled"
                                    ? SizedBox(
                                        height: 20,
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: DefaultButton(
                                                textColor: AppColor.blackColor,
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                height: 30,
                                                text: "Reschedule",
                                                onPress: () async {
                                                  final date = await pickDate();
                                                  if (date == null) return;
                                                  // final time = await picktime();
                                                  // if (time == null) return;

                                                  validFrom = DateTime(
                                                    date.year,
                                                    date.month,
                                                    date.day,
                                                  );
                                                  // final amPm = DateFormat('hh:mm a').format(validFrom!);
                                                  String dateRes =
                                                      "${date.day}-${date.month}-${date.year}";
                                                  print(dateRes);
                                                  final TimeOfDay? picked =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  );
                                                  String time = "";
                                                  if (picked != null) {
                                                    time =
                                                        picked.format(context);
                                                  }

                                                  if (dateRes.isNotEmpty &&
                                                      time.isNotEmpty) {
                                                    RescheduleModel model =
                                                        RescheduleModel(
                                                            appointmentDate:
                                                                dateRes,
                                                            appointmentTime:
                                                                time,
                                                            remarks: "thanks",
                                                            appointmentId:
                                                                appointment.id
                                                                    .toString(),
                                                            status:
                                                                "Rescheduled");
                                                    await profileProvider
                                                        .changeAppointmentSchedule(
                                                            appointments:
                                                                model);

                                                    setState(() {});
                                                  } else {
                                                    print("empty");
                                                  }
                                                },
                                                borderSide: BorderSide(
                                                    color: AppColor.green),
                                                radius: 20),
                                          ),
                                          AppConstant.kWidth(
                                              width: size.width * .01),
                                          Expanded(
                                            flex: 1,
                                            child: DefaultButton(
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                height: 30,
                                                text: "Cancel",
                                                textColor: AppColor.blackColor,
                                                onPress: () async {
                                                  RescheduleModel model =
                                                      RescheduleModel(
                                                          appointmentDate:
                                                              appointment
                                                                  .appointmentDate,
                                                          appointmentTime:
                                                              appointment
                                                                  .appointmentTime,
                                                          remarks: "thanks",
                                                          appointmentId:
                                                              appointment.id
                                                                  .toString(),
                                                          status: "Cancelled");
                                                  await profileProvider
                                                      .changeAppointmentSchedule(
                                                          appointments: model);

                                                  setState(() {});
                                                },
                                                borderSide: BorderSide(
                                                    color: AppColor.blackColor),
                                                radius: 20),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(""),
                                          ),
                                        ],
                                      ),
                                AppConstant.kheight(height: size.width * .004),
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      AppConstant.kheight(height: size.width * .01),
                  itemCount: data.length)
            ],
          );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> picktime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
