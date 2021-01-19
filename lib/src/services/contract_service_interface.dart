abstract class ContractService {
  String getCurrentOwnerAddress(BigInt productCode);
  bool checkAuthorship(String manufacturerAddress, BigInt manufacturerCode);
}