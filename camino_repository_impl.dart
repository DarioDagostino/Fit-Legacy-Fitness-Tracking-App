import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_legacy/domain/repositories/camino_repository_interface.dart';

class CaminoRepositoryImpl implements CaminoRepositoryInterface {
  final FirebaseFirestore _firestore;

  CaminoRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<int> getProgreso(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data()?['lastCompletedNodeId'] as int? ?? -1;
  }

  @override
  Future<void> updateProgreso(String userId, int lastCompletedNodeId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'lastCompletedNodeId': lastCompletedNodeId});
  }
}