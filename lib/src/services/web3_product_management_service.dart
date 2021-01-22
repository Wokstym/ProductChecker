import 'package:product_check/src/services/base_product_management_service.dart';
import 'package:web3dart/web3dart.dart';

class ProductManagementServiceImpl extends BaseProductManagementService {
  ProductManagementServiceImpl(String privateKey, String contractAddress,
      String infuraURL, String contractName)
      : super(privateKey, contractAddress, infuraURL, contractName);

  @override
  Future<String> getCurrentOwnerAddress(BigInt productCode) async {
    return await getProductOwner(productCode);
  }

  Future<String> getProductOwner(BigInt productCode) async {
    List<dynamic> response = await query("getCurrentOwner", [productCode]);
    return response[0].toString();
  }

  @override
  Future<String> shipProduct(String receiverAddress, BigInt productCode) async {
    return submit("shipProduct",
        [userAddress, EthereumAddress.fromHex(receiverAddress), productCode]);
  }

  @override
  Future<String> receiveProduct(BigInt productCode) async {
    return submit("receiveProduct", [productCode, userAddress]);
  }
}
