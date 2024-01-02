class ResponseProjectDataForFirebase {

  String? userName;
  int? farmerProjectId;
  String? projectName;
  String? userType;
  String? farmerName;
  String ?farmerAddress;
  String ?farmerId;
  String? ddeId;
  String? mccId;
  String? supplierId;
  String? projectImage;

  ResponseProjectDataForFirebase({
    this.userName,
    this.projectName,
    this.farmerProjectId,
    this.userType,
    this.farmerName,
    this.farmerAddress,
    this.farmerId,
    this.ddeId,
    this.mccId,
    this.supplierId,
    required this.projectImage,
  });

}