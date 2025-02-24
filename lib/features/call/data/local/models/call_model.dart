import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_app/features/call/domain/entities/call_entities.dart';

class CallModel extends CallEntity{
  final String? callId;
  final String? callerId;
  final String? callerName;
  final String? callerProfileUrl;

  final String? receiverId;
  final String? receiverName;
  final String? receiverProfileUrl;
  final bool? isCallDialed;
  final bool? isMissed;
  final Timestamp? createdAt;

  CallModel(
      {this.callId,
        this.callerId,
        this.callerName,
        this.callerProfileUrl,
        this.receiverId,
        this.receiverName,
        this.receiverProfileUrl,
        this.isCallDialed,
        this.isMissed,
        this.createdAt,}) : super(
    callId: callId,
    callerId: callerId,
    callerName: callerName,
    callerProfileUrl: callerProfileUrl,
    isCallDialed: isCallDialed,
    receiverId: receiverId,
    receiverName: receiverName,
    receiverProfileUrl: receiverProfileUrl,
    isMissed: isMissed,
    createdAt: createdAt,
  );

  factory CallModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return CallModel(
      callId: snap['callId'],
      callerId: snap['callerId'],
      callerName: snap['callerName'],
      callerProfileUrl: snap['callerProfileUrl'],
        receiverId: snap['receiverId'],
      receiverName: snap['receiverName'],
        receiverProfileUrl: snap['receiverProfileUrl'],
        isCallDialed: snap['isCallDialed'],
        isMissed: snap['isMissed'],
        createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "callID" : callId,
    "callerId": callerId,
    "callerName" : callerName,
    "callerProfileUrl": callerProfileUrl,
    "receiverId" : receiverId,
    "receiverName" : receiverName,
    "receiverProfileUrl" : receiverProfileUrl,
    "isCallDialed" : isCallDialed,
    "isMissed" : isMissed,
    "created" : createdAt,
  } ;

}