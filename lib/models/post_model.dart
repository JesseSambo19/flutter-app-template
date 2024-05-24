//! The Post model class represents the structure of a post.
class PostModel {
  final int id;        //! Unique identifier for the post.
  final String title;  //! Title of the post.
  final String body;   //! Body content of the post.

  //! Constructor to initialize all the properties.
  PostModel({
    required this.id,
    required this.title,
    required this.body,
  });

  //! Factory method to create a Post instance from JSON data.
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],           //! Extracting ID from JSON.
      title: json['title'],     //! Extracting title from JSON.
      body: json['body'],       //! Extracting body content from JSON.
    );
  }
}