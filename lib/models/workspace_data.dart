class WorkspaceData {
  String id;
  String name;
  String email;
  String password;

  WorkspaceData({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
  });

  factory WorkspaceData.fromJson(Map<String, dynamic> json) {
    return WorkspaceData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
