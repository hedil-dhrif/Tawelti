class Floor {
  int id;
  String nom;
  int RestaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  Floor({this.id, this.nom, this.createdAt, this.updatedAt,this.RestaurantId});

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "nom":nom,
      "RestaurantId":RestaurantId,
    };
  }

  factory Floor.fromJson(Map<String, dynamic> item) {
    return Floor(
      id: item['id'],
      nom: item['nom'],
      RestaurantId: item['RestaurantId'],
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt: item['updatedAt'] != null
          ? DateTime.parse(item['updatedAt'])
          : null,
    );
  }
}
