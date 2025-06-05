class WorkspaceData {
  String uid;
  String id;
  String name;
  String description;
  String asset;

  WorkspaceData({
    this.uid = '',
    this.id = '',
    this.name = '',
    this.description = '',
    this.asset = '',
  });

  factory WorkspaceData.fromJson(Map<String, dynamic> json) {
    return WorkspaceData(
      uid: json['uid'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      asset: json['asset'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      'name': name,
      'description': description,
      'asset': asset,
    };
  }
}
