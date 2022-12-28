class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
class UnknownException {
  String message;
  UnknownException(this.message);
}

//  try {
      
//       if (data["status"] == 200) {
        

//       } else {
//         throw data["message"];
//       }
//     } on SocketException {
//       throw Failure('No Internet connection');
//     } on HttpException {
//       throw Failure("Couldn't find the post");
//     } on FormatException {
//       throw Failure("Bad response format");
//     } catch (e) {
//       throw Failure("Something Went Wrong");
//     }