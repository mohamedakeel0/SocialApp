class PostModel {
  late String name;
  late String uId;
  late String image;
  late String dataTime;
  late String text;
  late String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dataTime,
    required this.text,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    dataTime = json['dataTime'];
    text = json['text'];
    postImage = json['postImage'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'text': text,
      'dataTime': dataTime,
    };
  }
}
