class Event {
  int id;
  String nom;
  String category;
  String description;
  int restaurantId;
  DateTime dateDebut;
  DateTime dateFin;
  DateTime createdAt;
  DateTime updatedAt;

  Event(
      {this.id,
      this.nom,
      this.category,
      this.description,
      this.restaurantId,
      this.dateDebut,
      this.dateFin,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'RestaurantId':restaurantId,
      'category':category,
      'Description':description,
      // 'dateDebut':dateDebut.toIso8601String(),
      // 'dateFin':dateFin.toIso8601String(),
      // 'createdAt':dateDebut,
      // 'updatedAt':dateFin,
    };
  }
  factory Event.fromJson(Map<String, dynamic> item) {
    return Event(
      id: item['id'],
      nom: item['nom'],
      category: item['category'],
      description: item['Description'],
      restaurantId: item['RestaurantId'],
      // dateDebut: DateTime.parse(item['dateDebut']),
      // dateFin:
      //     item['dateFin'] != null ? DateTime.parse(item['dateFin']) : null,
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt:
          item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
