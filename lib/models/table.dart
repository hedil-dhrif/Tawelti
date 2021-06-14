class RestaurantTable {
  int id;
  int code;
  int nbCouverts;
  int zoneId;
  //int ZoneId;
  int tolerance;
  String description;
  int etat;
  int x;
  int y;
  DateTime createdAt;
  DateTime updatedAt;

  RestaurantTable({
    this.id,
    this.code,
    this.nbCouverts,
    this.zoneId,
    //this.ZoneId,
    this.tolerance,
    this.description,
    this.x,
    this.etat,
    this.y,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'tolerance': tolerance,
      'nbCouverts': nbCouverts,
      'etat':etat,
      'ZoneId':zoneId,
    };
  }

  factory RestaurantTable.fromJson(Map<String, dynamic> item) {
    return RestaurantTable(
     id: item['id'],
      code: item['code'],
      nbCouverts: item['nbCouverts'],
      description: item['Description'],
      zoneId: item['ZoneId'],
      //ZoneId: item['zoneId'],
      etat: item['etat'],
      tolerance: item['tolerance'],
      x: item['x'],
      y: item['y'],
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt: item['updatedAt'] != null
          ? DateTime.parse(item['updatedAt'])
          : null,
    );
  }
}
