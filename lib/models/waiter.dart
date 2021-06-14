class Waiter {
  int id;
  String nom;
  String prenom;
  String adresse;
  String telephone;
  // int zoneId;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  Waiter(
      {this.id,
      this.nom,
      this.prenom,
      this.adresse,
        this.restaurantId,
      this.telephone,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'adresse': adresse,
      'telephone':telephone,
      'RestaurantId':restaurantId,
    };
  }

  factory Waiter.fromJson(Map<String, dynamic> item) {
    return Waiter(
      id: item['id'],
      nom: item['nom'],
      prenom: item['prenom'],
      adresse: item['adresse'],
      telephone: item['telephone'],
      restaurantId: item['RestaurantId'],
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt: item['updatedAt'] != null
          ? DateTime.parse(item['updatedAt'])
          : null,
    );
  }
}
