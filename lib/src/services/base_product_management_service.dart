import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:product_check/src/services/product_management_interface.dart';
import 'package:web3dart/web3dart.dart';

abstract class BaseProductManagementService implements IProductManagementService {
  static final String contractPath = "assets/ABI.json";
  DeployedContract contract;
  EthereumAddress userAddress;
  EthPrivateKey credentials;
  Web3Client ethClient;

  BaseProductManagementService(String privateKey, String contractAddress,
      String infuraURL, String contractName) {
    credentials = EthPrivateKey.fromHex(privateKey);
    ethClient = Web3Client(infuraURL, Client());
    setUserAddressFrom(privateKey);
    setContract(contractName, contractAddress);
  }

  void setUserAddressFrom(String privateKey) async {
    userAddress = await credentials.extractAddress();
  }

  void setContract(String contractName, contactAddress) async {
    String abi = await rootBundle.loadString(contractPath);
    contract = DeployedContract(ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contactAddress));
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final ethFunction = contract.function(functionName);
    return await ethClient.call(
        contract: contract, function: ethFunction, params: args);
  }

  void submit(String functionName, List<dynamic> args) async {
    final ethFunction = contract.function(functionName);
    await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        fetchChainIdFromNetworkId: true);
  }

  Future<String> getCurrentOwnerAddress(BigInt productCode);

  void shipProduct(String receiverAddress, BigInt productCode);

  void receiveProduct(BigInt productCode);
}
