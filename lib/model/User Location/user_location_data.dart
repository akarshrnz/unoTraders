import 'package:hive/hive.dart';
part 'user_location_data.g.dart';

@HiveType(typeId: 1)
class UserLocationDb {
  @HiveField(0)
  String locationName;
  @HiveField(1)
  String latitude;
  @HiveField(2)
  String longitude;

  UserLocationDb({
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });
}
