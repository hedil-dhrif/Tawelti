class Zone {
  int id;
  String nom;
  String NbTables;
  //int etat;
  int etageId;
  DateTime createdAt;
  DateTime updatedAt;
  Zone(
      {this.id,
      this.nom,
      this.etageId,
      this.NbTables,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      'EtageId':etageId,
      'nom': nom,
    };
  }
  factory Zone.fromJson(Map<String, dynamic> item) {
    return Zone(
      id: item['id'],
      nom: item['nom'],
      NbTables: item['NBzones'],
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt: item['updatedAt'] != null
          ? DateTime.parse(item['updatedAt'])
          : null,
    );
  }
}
