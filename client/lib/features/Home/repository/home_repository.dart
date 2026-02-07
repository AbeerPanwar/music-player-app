import 'package:http/http.dart' as http;
import 'package:music_player/core/constants/server_constants.dart';

class HomeRepository {
  Future<void> uploadSong(String? songPath, String? imagePath) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ServerConstants.serverURL}/song/upload'),
    );

    request
      ..files.addAll([
        await http.MultipartFile.fromPath('song', songPath!),
        await http.MultipartFile.fromPath('thumbnail', imagePath!),
      ])
      ..fields.addAll({
        'artist': 'Abeer',
        'song_name': 'whats my name',
        'hex_code': 'FFFFFF',
      })
      ..headers.addAll({
        'x-auth-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI3NzE2OTFkLTIzN2MtNDIzYS1hZjkyLTVlNTEyM2YxMDJkMyJ9.sSFOa73k7F6fi9onnFw2SIUl0xyrwHpfwbySoo8-EjQ',
      });

    final res = await request.send();
    print(res);
  }
}
