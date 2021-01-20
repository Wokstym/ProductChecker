class Record {
  String productCode;
  String manufacturerCode;

  Record(String productCode, String manufacturerCode) {
    this.productCode = productCode;
    this.manufacturerCode = manufacturerCode;
  }

  static Record fromNFCPayload(String nfcPayload) {
    var split = nfcPayload.split(";");
    return new Record(split[0], split[1]);
  }

  String getNFCFormattedString() {
    return productCode + ";" + manufacturerCode;
  }

  @override
  String toString() {
    return 'Record{productCode: $productCode, manufacturerCode: $manufacturerCode}';
  }
}