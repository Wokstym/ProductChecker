import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:product_check/src/services/contract_service_interface.dart';
import 'package:web3dart/web3dart.dart';

class ContractServiceImpl implements ContractService {

  static final String contractPath = "assets/ABI.json";
  final String myAddress;
  final String infuraURL;
  final String contractAddress;
  final String contractName;
  String productOwner;
  Client httpClient;
  Web3Client ethClient;

  ContractServiceImpl(this.myAddress, this.contractAddress, this.infuraURL,
      this.contractName) {
    httpClient = Client();
    ethClient = Web3Client(infuraURL, httpClient);
  }

  @override
  bool checkAuthorship(String manufacturerAddress, BigInt manufacturerCode) {
    return false;
  }

  @override
  String getCurrentOwnerAddress(BigInt productCode) {
    getProductOwner(productCode).then((value) => {
      productOwner = value
    });
    return productOwner;
  }

  Future<String> getProductOwner(BigInt productCode) async {
    List<dynamic> response =
    await query("getCurrentOwner", [productCode]);
    return response[0].toString();
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    return await ethClient.call(
        contract: contract, function: ethFunction, params: args);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString(contractPath);
    return DeployedContract(ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contractAddress));
  }
}
