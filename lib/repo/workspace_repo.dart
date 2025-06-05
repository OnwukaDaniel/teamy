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
      data.add(
        WorkspaceData(
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
}
