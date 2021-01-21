abstract class ContractService {
  Future<String> getCurrentOwnerAddress(BigInt productCode);

  bool checkAuthorship(String manufacturerAddress, BigInt manufacturerCode);
}
