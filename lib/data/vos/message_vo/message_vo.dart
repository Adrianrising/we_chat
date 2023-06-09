
import 'package:json_annotation/json_annotation.dart';
part 'message_vo.g.dart';
@JsonSerializable()
class MessageVO{
  @JsonKey(name: 'message')
  String ? message;

  @JsonKey(name: 'dateTime')
  DateTime ? dateTime;

  @JsonKey(name: 'sender_id')
  String ? senderId;

  @JsonKey(name: 'message_id')
  String ? messageId;

  MessageVO(this.message, this.dateTime, this.senderId,this.messageId);

  factory MessageVO.fromJson(Map<String,dynamic>json)=>_$MessageVOFromJson(json);

  Map<String,dynamic> toJson()=>_$MessageVOToJson(this);
}