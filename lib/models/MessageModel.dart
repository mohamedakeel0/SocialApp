class MessageModel{
  late String senderId;
  late String receiverId;
  late String dataTime;
  late String text;
   String? image;
  MessageModel({
    required  this.senderId,
    required  this.receiverId,
    required  this.dataTime,
    required  this.text,
    required  this.image,
    });
  MessageModel.fromJson(Map<String,dynamic>?json){
    senderId=json!['senderId'];
    receiverId=json['receiverId'];
    dataTime=json['dataTime'];
    text=json['text'];
    image=json['image'];
  }
  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dataTime':dataTime,
      'text':text,
      'image':image,
    };
  }
}
