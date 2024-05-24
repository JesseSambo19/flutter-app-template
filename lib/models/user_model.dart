import 'package:uuid/uuid.dart';

//! The User model class to represent the structure of a user.
class UserModel {
  //! A unique identifier for the user.
  final String id;
  
  //! The first name of the user.
  final String firstName;
  
  //! The last name of the user.
  final String lastName;
  
  //! The email address of the user.
  final String email;
  
  //! The phone number of the user.
  final String phone;
  
  //! The URL of the user's profile picture.
  final String picture;

  //! Constructor to initialize all the fields of the User class.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.picture,
  });

  //! Factory constructor to create a User instance from a JSON object.
  //! The JSON object structure is based on the response from the Random User API.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      //! Generate a unique ID using the uuid package.
      id: const Uuid().v4(),
      //! Extract the first name from the JSON object.
      firstName: json['name']['first'],
      //! Extract the last name from the JSON object.
      lastName: json['name']['last'],
      //! Extract the email from the JSON object.
      email: json['email'],
      //! Extract the phone number from the JSON object.
      phone: json['phone'],
      //! Extract the URL of the profile picture from the JSON object.
      picture: json['picture']['large'],
    );
  }
}
