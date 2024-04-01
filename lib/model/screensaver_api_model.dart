class ScreenSaverMastersResponse {
  ScreenSaverMastersResponse({
    this.screenSaverMasters,
  });

  final List<ScreenSaverMaster>? screenSaverMasters;

  factory ScreenSaverMastersResponse.fromJson(Map<String, dynamic> json) =>
      ScreenSaverMastersResponse(
        screenSaverMasters: json["ScreenSaverMasters"] == null
            ? null
            : List<ScreenSaverMaster>.from(json["ScreenSaverMasters"]
                .map((x) => ScreenSaverMaster.fromJson(x))),
      );
}

class ScreenSaverMaster {
  ScreenSaverMaster({
    this.screenSaverId,
    this.imagePath,
  });

  final String? screenSaverId;
  final String? imagePath;

  factory ScreenSaverMaster.fromJson(Map<String, dynamic> json) =>
      ScreenSaverMaster(
        imagePath: json["ImagePath"],
      );
  Map<String, dynamic> toJson() => {
        "ScreenSaverID": screenSaverId,
        "ImagePath": imagePath,
      };
}
