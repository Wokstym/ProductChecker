abstract class IProductManagementService {
  Future<String> getCurrentOwnerAddress(BigInt productCode);

  void shipProduct(String receiverAddress, BigInt productCode);

  void receiveProduct(BigInt productCode);
}