import 'package:teamy/imports.dart';

class WorkspaceRepositoryImpl implements IWorkspaceRepository {
  final IAuthRepo authRepo = AuthRepo();

  @override
  Future<NetworkData> createWorkSpace(
    String name,
    String desc, {
    String? asset,
  }) async {
    try {
      var jsonString = await LocalStorage.getStringList(
        Preferences.workspaceJson,
      );
      final data =
          jsonString.map((e) => WorkspaceData.fromJson(jsonDecode(e))).toList();
      final local = await authRepo.getLocalUser();
      if (local == null) {
        return NetworkData(message: 'Unable to get local user. Sign in');
      }
      data.add(
        WorkspaceData(
          uid: local.id,
          name: name,
          description: desc,
          asset: asset ?? '',
          id: 'WorkSpace_${DateTime.now().toIso8601String()}',
        ),
      );
      jsonString = data.map((e) => jsonEncode(e.toJson())).toList();
      await LocalStorage.setStringList(Preferences.workspaceJson, jsonString);
      return NetworkData(status: true, data: null, message: 'Success');
    } catch (e) {
      return NetworkData(message: 'Failed to create workspace try again $e');
    }
  }

  @override Future<NetworkData> deleteWorkspace(String workspaceId) async {
    try {
      var jsonString = await LocalStorage.getStringList(
        Preferences.workspaceJson,
      );

      final data = jsonString
          .map((e) => WorkspaceData.fromJson(jsonDecode(e)))
          .toList();

      data.removeWhere((workspace) => workspace.id == workspaceId);

      jsonString = data.map((e) => jsonEncode(e.toJson())).toList();
      await LocalStorage.setStringList(Preferences.workspaceJson, jsonString);

      return NetworkData(status: true, message: 'Workspace deleted successfully');
    } catch (e) {
      return NetworkData(message: 'Failed to delete workspace: $e');
    }
  }

  @override Future<NetworkData> getWorkSpaces() async {
    try {
      final jsonString = await LocalStorage.getStringList(
        Preferences.workspaceJson,
      );
      final local = await authRepo.getLocalUser();
      if (local == null) {
        return NetworkData(message: 'Unable to get local user. Sign in');
      }
      final data =
          jsonString.map((e) => WorkspaceData.fromJson(jsonDecode(e))).toList();
      final workspaces = data.where((e) => e.uid == local.id).toList();
      return NetworkData(status: true, data: workspaces, message: 'Success');
    } catch (e) {
      return NetworkData(message: 'Failed to get workspaces try again $e');
    }
  }

  @override Future<NetworkData> createTask(TaskData data) async {
    try {
      var jsonString = await LocalStorage.getStringList(Preferences.tasksJson);
      final taskList =
          jsonString.map((e) => TaskData.fromJson(jsonDecode(e))).toList();
      taskList.add(data);
      jsonString = taskList.map((e) => jsonEncode(e.toJson())).toList();
      jsonString = jsonString.reversed.toList();
      await LocalStorage.setStringList(Preferences.tasksJson, jsonString);
      return NetworkData(status: true, data: null, message: 'Success');
    } catch (e) {
      return NetworkData(message: 'Failed to create task try again $e');
    }
  }

  @override Future<NetworkData> getTasks(String workspaceId) async {
    try {
      final jsonString = await LocalStorage.getStringList(
        Preferences.tasksJson,
      );
      final taskList =
          jsonString.map((e) => TaskData.fromJson(jsonDecode(e))).toList();
      final workspaceTasks =
          taskList.where((task) => task.workspaceId == workspaceId).toList();
      return NetworkData(
        status: true,
        data: workspaceTasks,
        message: 'Success',
      );
    } catch (e) {
      return NetworkData(message: 'Failed to get tasks try again $e');
    }
  }

  @override Future<NetworkData> editTask(TaskData updatedTask) async {
    try {
      var jsonString = await LocalStorage.getStringList(Preferences.tasksJson);
      final taskList =
          jsonString.map((e) => TaskData.fromJson(jsonDecode(e))).toList();

      // Find the task to edit
      final taskIndex = taskList.indexWhere(
        (task) => task.id == updatedTask.id,
      );
      if (taskIndex == -1) {
        return NetworkData(message: 'Task not found');
      }

      // Replace the task with the updated data
      taskList[taskIndex] = updatedTask;

      // Save the updated list back to local storage
      jsonString = taskList.map((e) => jsonEncode(e.toJson())).toList();
      await LocalStorage.setStringList(Preferences.tasksJson, jsonString);

      return NetworkData(
        status: true,
        data: null,
        message: 'Task updated successfully',
      );
    } catch (e) {
      return NetworkData(message: 'Failed to update task try again $e');
    }
  }

  @override Future<NetworkData> editComment(
    TaskData task,
    String oldComment,
    String newComment,
  ) async {
    try {
      var jsonString = await LocalStorage.getStringList(Preferences.tasksJson);
      final taskList =
          jsonString.map((e) => TaskData.fromJson(jsonDecode(e))).toList();

      final taskIndex = taskList.indexWhere((task) => task.id == task.id);
      if (taskIndex == -1) {
        return NetworkData(message: 'Task not found');
      }
      final commentIndex = taskList[taskIndex].comments.indexWhere(
        (e) => e == oldComment,
      );
      if (commentIndex == -1) {
        return NetworkData(message: 'Comment not found');
      }
      taskList[taskIndex].comments[commentIndex] = newComment;

      jsonString = taskList.map((e) => jsonEncode(e.toJson())).toList();
      await LocalStorage.setStringList(Preferences.tasksJson, jsonString);

      return NetworkData(
        status: true,
        data: null,
        message: 'Comment updated successfully',
      );
    } catch (e) {
      return NetworkData(message: 'Failed to update task try again $e');
    }
  }

  @override Future<NetworkData> addComment(TaskData task, String comment) async {
    try {
      var jsonString = await LocalStorage.getStringList(Preferences.tasksJson);
      final taskList =
          jsonString.map((e) => TaskData.fromJson(jsonDecode(e))).toList();

      final taskIndex = taskList.indexWhere((task) => task.id == task.id);
      if (taskIndex == -1) {
        return NetworkData(message: 'Task not found');
      }
      taskList[taskIndex].comments.add(comment);

      jsonString = taskList.map((e) => jsonEncode(e.toJson())).toList();
      await LocalStorage.setStringList(Preferences.tasksJson, jsonString);

      return NetworkData(
        status: true,
        data: null,
        message: 'Comment added successfully',
      );
    } catch (e) {
      return NetworkData(message: 'Failed to update task try again $e');
    }
  }

  @override Future<NetworkData> deleteComment(
    TaskData task,
    String comment,
  ) async {
    try {
      var jsonString = await LocalStorage.getStringList(Preferences.tasksJson);
      final taskList =
          jsonString.map((e) => TaskData.fromJson(jsonDecode(e))).toList();

      final taskIndex = taskList.indexWhere((task) => task.id == task.id);
      if (taskIndex == -1) {
        return NetworkData(message: 'Task not found');
      }
      taskList[taskIndex].comments.remove(comment);

      jsonString = taskList.map((e) => jsonEncode(e.toJson())).toList();
      await LocalStorage.setStringList(Preferences.tasksJson, jsonString);

      return NetworkData(
        status: true,
        data: null,
        message: 'Comment deleted successfully',
      );
    } catch (e) {
      return NetworkData(message: 'Failed to update task try again $e');
    }
  }

  @override Future<NetworkData> deleteTask(String taskId) async {
    try {
      var jsonString = await LocalStorage.getStringList(Preferences.tasksJson);
      final taskList =
          jsonString.map((e) => TaskData.fromJson(jsonDecode(e))).toList();

      // Find the task to delete
      final taskIndex = taskList.indexWhere((task) => task.id == taskId);
      if (taskIndex == -1) {
        return NetworkData(message: 'Task not found');
      }

      // Remove the task from the list
      taskList.removeAt(taskIndex);

      // Save the updated list back to local storage
      jsonString = taskList.map((e) => jsonEncode(e.toJson())).toList();
      await LocalStorage.setStringList(Preferences.tasksJson, jsonString);

      return NetworkData(
        status: true,
        data: null,
        message: 'Task deleted successfully',
      );
    } catch (e) {
      return NetworkData(message: 'Failed to delete task try again $e');
    }
  }
}
