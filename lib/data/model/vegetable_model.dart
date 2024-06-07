class VegetableModel {
  String? id;
  String? englishName;
  String? familyName;
  String? aKA;
  String? tagalogName;
  String? botanicalName;
  String? description;
  String? vegetableType;
  String? lifespan;
  String? plantingTime;
  String? harvestTime;
  String? imageURLs;

  VegetableModel(
      {this.id,
      this.englishName,
      this.familyName,
      this.aKA,
      this.tagalogName,
      this.botanicalName,
      this.description,
      this.vegetableType,
      this.lifespan,
      this.plantingTime,
      this.harvestTime,
      this.imageURLs});

  VegetableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    englishName = json['english_name'];
    familyName = json['family_name'];
    aKA = json['a_k_a'];
    tagalogName = json['tagalog_name'];
    botanicalName = json['botanical_name'];
    description = json['description'];
    vegetableType = json['vegetable_type'];
    lifespan = json['lifespan'];
    plantingTime = json['planting_time'];
    harvestTime = json['harvest_time'];
    imageURLs = json['imageURLs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['english_name'] = englishName;
    data['family_name'] = familyName;
    data['a_k_a'] = aKA;
    data['tagalog_name'] = tagalogName;
    data['botanical_name'] = botanicalName;
    data['description'] = description;
    data['vegetable_type'] = vegetableType;
    data['lifespan'] = lifespan;
    data['planting_time'] = plantingTime;
    data['harvest_time'] = harvestTime;
    data['imageURLs'] = imageURLs;
    return data;
  }
}
