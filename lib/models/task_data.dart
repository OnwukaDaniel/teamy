class TaskData {
  String workspaceId;
  String id;
  String deadline;
  String description;
  String comments;
  String status;
  List<String>? tags;

  TaskData({
    this.workspaceId = '',
    this.id = '',
    this.deadline = '',
    this.description = '',
    this.comments = '',
    this.status = '',
    this.tags,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      workspaceId: json['workspaceId'] ?? '',
      id: json['id'] ?? '',
      deadline: json['deadline'] ?? '',
      description: json['description'] ?? '',
      comments: json['comments'] ?? '',
      status: json['status'] ?? '',
      tags: ((json['tags'] ?? []) as List).map((e)=> e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workspaceId': workspaceId,
      'id': id,
      'deadline': deadline,
      'description': description,
      'comments': comments,
      'status': status,
      'tags': tags,
    };
  }
}
