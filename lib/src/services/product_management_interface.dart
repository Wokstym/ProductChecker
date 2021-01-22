abstract class IProductManagementService {
  Future<String> getCurrentOwnerAddress(BigInt productCode);

  Future<String> shipProduct(String receiverAddress, BigInt productCode);

  Future<String> receiveProduct(BigInt productCode);
}