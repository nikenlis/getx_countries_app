class CountryModel {

  final String officialName;
  final List<String> capitals;
  final String flag;

  CountryModel({
    required this.officialName,
    required this.capitals,
    required this.flag,
  });

  factory CountryModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return CountryModel(

      officialName:
          json["name"]?["official"] ?? "-",

      capitals:
          json["capital"] != null
              ? List<String>.from(
                  json["capital"],
                )
              : [],

      flag:
          json["flags"]?["png"] ?? "",
    );
  }
}