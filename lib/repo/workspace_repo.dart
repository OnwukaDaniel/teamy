import 'package:teamy/imports.dart';

class WorkspaceRepo {
  static Future<NetworkData> createWorkSpace(
    String name,
    String desc, {
    String? asset,
  }) async {
    try {
      final jsonString = await LocalStorage.getStringList(
        Preferences.workspaceJson,
      );
      final data =
          jsonString.map((e) => WorkspaceData.fromJson(jsonDecode(e))).toList();
      final local = await AuthRepo.getLocalUser();
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
      return NetworkData(status: true, data: null, message: 'Success');
    } catch (e) {
      return NetworkData(message: 'Failed to create workspace try again $e');
    }
  }

  static Future<NetworkData> getWorkSpaces() async {
    try {
      final jsonString = await LocalStorage.getStringList(
        Preferences.workspaceJson,
      );
      final local = await AuthRepo.getLocalUser();
      if (local == null) {
        return NetworkData(message: 'Unable to get local user. Sign in');
      }
      final data =
          jsonString.map((e) => WorkspaceData.fromJson(jsonDecode(e))).toList();
      final workspaces = data.where((e) => e.uid == local.id).toList();
      return NetworkData(status: true, data: workspaces, message: 'Success');
    } catch (e) {
      return NetworkData(message: 'Failed to create workspace try again $e');
    }
  }
}
