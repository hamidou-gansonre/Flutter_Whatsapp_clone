import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_app/features/app/const/firebase_collection_const.dart';
import 'package:whatsapp_app/features/call/data/local/models/call_model.dart';
import 'package:whatsapp_app/features/call/data/remote/call_remote_data_source.dart';
import 'package:whatsapp_app/features/call/domain/entities/call_entities.dart';

class CallRemoteDatasourceImpl implements CallRemoteDataSource {
  final FirebaseFirestore fireStore;

  CallRemoteDatasourceImpl({required this.fireStore});

  @override
  Future<void> endCall(CallEntity call) async {
    final callCollection = fireStore.collection(FirebaseCollectionConst.call);
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
    } catch (e) {
      print("Something went wrong for ending call");
    }
  }
/*
  @override
  Future<String> getCallChannelId(String uid) async {
    final callCollection = fireStore.collection(FirebaseCollectionConst.call);
    return callCollection.doc(uid).get().then((callCollection) {
      if(callCollection.exists){
        return callCollection.data()!['callId'];
      }
      return Future.value("");
    });
  } */
  //*********//
  @override
  Future<String> getCallChannelId(String uid) async {

    final callCollection = fireStore.collection(FirebaseCollectionConst.call);

    return callCollection
        .doc(uid)
        .get()
        .then((callConnection) {
      if (callConnection.exists) {
        return callConnection.data()!['callId'];

      }
      return Future.value("");

    });
  }

  @override
  Stream<List<CallEntity>> getMyCallHistory(String uid) {
    final myHistoryCollection = fireStore
        .collection(FirebaseCollectionConst.users)
        .doc(uid)
        .collection(FirebaseCollectionConst.callHistory)
        .orderBy("createdAt", descending: true);

    return myHistoryCollection.snapshots().map((querySnapshots) =>
        querySnapshots.docs.map((e) => CallModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<CallEntity>> getUserCalling(String uid) {
    final callCollection = fireStore.collection(FirebaseCollectionConst.call);
    return callCollection
        .where("callerId", isEqualTo: uid)
        .limit(1)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => CallModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> makeCall(CallEntity call) async {
    final callCollection = fireStore.collection(FirebaseCollectionConst.call);
    String callId = callCollection.doc().id;

    final callerData = CallModel(
      callId: callId,
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      isCallDialed: true,
      isMissed: false,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    final receiverData = CallModel(
      callId: callId,
      callerId: call.receiverId,
      callerName: call.receiverName,
      callerProfileUrl: call.receiverProfileUrl,
      isCallDialed: false,
      isMissed: false,
      receiverId: call.callerId,
      receiverName: call.callerName,
      receiverProfileUrl: call.callerProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();
    try {
      await callCollection.doc(call.callerId).set(callerData);
      await callCollection.doc(call.receiverId).set(receiverData);
    } catch (e) {
      print("Something went wrong while making a call");
    }
  }

  @override
  Future<void> saveCallHistory(CallEntity call) async {
    final myHistoryCollection = fireStore
        .collection(FirebaseCollectionConst.users)
        .doc(call.callerId)
        .collection(FirebaseCollectionConst.callHistory);
    final otherHistoryCollection = fireStore
        .collection(FirebaseCollectionConst.users)
        .doc(call.receiverId)
        .collection(FirebaseCollectionConst.callHistory);

    final callData = CallModel(
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      callId: call.callId,
      isCallDialed: call.isCallDialed,
      isMissed: call.isMissed,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    try {
      await myHistoryCollection
          .doc(call.callId)
          .set(callData, SetOptions(merge: true));
      await otherHistoryCollection
          .doc(call.callId)
          .set(callData, SetOptions(merge: true));
    } catch (e) {
      print("Something went wrong while saving call history");
    }
  }

  @override
  Future<void> updateCallHistoryStatus(CallEntity call) async {
    final myHistoryCollection = fireStore.collection(FirebaseCollectionConst.users).doc(call.callerId).collection(FirebaseCollectionConst.callHistory);
    final otherHistoryCollection = fireStore.collection(FirebaseCollectionConst.users).doc(call.receiverId).collection(FirebaseCollectionConst.callHistory);

    Map<String, dynamic> myHistoryInfo = {};
    Map<String, dynamic> otherHistoryInfo = {};

    if(call.isCallDialed != null) myHistoryInfo['isCallDialed'] = call.isCallDialed;
    if(call.isMissed != null) myHistoryInfo['isMissed'] = call.isMissed;

    if(call.isCallDialed != null) otherHistoryInfo['isCallDialed'] = call.isCallDialed;
    if(call.isMissed != null) otherHistoryInfo['isMissed'] = call.isMissed;

    myHistoryCollection.doc(call.callId).update(myHistoryInfo);
    otherHistoryCollection.doc(call.callId).update(otherHistoryInfo);
  }
}
