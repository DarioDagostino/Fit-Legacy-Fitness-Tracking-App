abstract class CaminoRepositoryInterface {
  Future<int> getProgreso(String userId);
  Future<void> updateProgreso(String userId, int lastCompletedNodeId);
}