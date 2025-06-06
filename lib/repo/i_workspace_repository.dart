import 'package:teamy/imports.dart';

abstract class IWorkspaceRepository {
  Future<NetworkData> createWorkSpace(String name, String desc, {String? asset});
  Future<NetworkData> deleteWorkspace(String workspaceId);
  Future<NetworkData> getWorkSpaces();
  Future<NetworkData> createTask(TaskData data);
  Future<NetworkData> getTasks(String workspaceId);
  Future<NetworkData> editTask(TaskData updatedTask);
  Future<NetworkData> addComment(TaskData task, String comment);
  Future<NetworkData> editComment(TaskData task, String oldComment, String newComment);
  Future<NetworkData> deleteComment(TaskData task, String comment);
  Future<NetworkData> deleteTask(String taskId);
}
