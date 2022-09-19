import 'dart:convert';

import 'package:SimhegaM/constants/var_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/models/hibahpost_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

class HibahCompService {
  Future<APIResponse<FeedBackUsl>> uslGmbrAdd(
      String usl, String gmbrnm, String path) async {
    Uri newApiUrl = Uri.parse('$apiURL/uslgmbr/insertDataM');
    final send = http.MultipartRequest('POST', newApiUrl);
    send.fields["uslgmbr_usl"] = usl;
    send.fields["uslgmbr_nm"] = gmbrnm;

    send.files.add(await http.MultipartFile.fromPath(
      'uslgmbr_fl',
      path,
    ));
    try {
      final streamedResponse = await send.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (streamedResponse.statusCode == 200) {
        final jsonData = json.decode(response.body)['response'];
        return APIResponse<FeedBackUsl>(
          data: FeedBackUsl.fromJson(jsonData),
          status: streamedResponse.statusCode,
          dialog: (jsonData['type'] == "info")
              ? DialogType.INFO
              : (jsonData['type'] == "warning")
                  ? DialogType.WARNING
                  : DialogType.SUCCES,
        );
      } else {
        final jsonData = json.decode(response.body)['response'];
        return APIResponse<FeedBackUsl>(
          error: true,
          errorMessage: 'Terjadi Kesalahan',
          data: FeedBackUsl.fromJson(jsonData),
          status: streamedResponse.statusCode,
          dialog: DialogType.ERROR,
        );
      }
    } catch (e) {
      return APIResponse<FeedBackUsl>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        dialog: DialogType.ERROR,
      );
    }
  }

  Future<APIResponse<FeedBackUsl>> uslGmbrDelete(String uslGmbrIdEx) {
    Uri newApiUrl = Uri.parse('$apiURL/uslgmbr/deleteDataM/$uslGmbrIdEx');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        return APIResponse<FeedBackUsl>(
          data: FeedBackUsl.fromJson(jsonData),
          status: data.statusCode,
          dialog: (jsonData['type'] == "info")
              ? DialogType.INFO
              : (jsonData['type'] == "warning")
                  ? DialogType.WARNING
                  : DialogType.SUCCES,
        );
      } else {
        final jsonData = json.decode(data.body)['response'];
        return APIResponse<FeedBackUsl>(
          error: true,
          data: FeedBackUsl.fromJson(jsonData),
          errorMessage: 'Terjadi Kesalahan',
          status: jsonData.statusCode,
          dialog: DialogType.ERROR,
        );
      }
    }).catchError((_) => APIResponse<FeedBackUsl>(
          error: true,
          errorMessage: 'Terjadi Kesalahan',
          dialog: DialogType.ERROR,
        ));
  }

  Future<APIResponseHibah<List<SrtForList>>> getSrtListPage() {
    Uri newApiUrl = Uri.parse('$apiURL/srt/getAllM');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final srtList = <SrtForList>[];
        for (var item in jsonData) {
          srtList.add(SrtForList.fromJson(item));
        }
        return APIResponseHibah<List<SrtForList>>(data: srtList);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final srtList = <SrtForList>[];
        for (var item in jsonData) {
          srtList.add(SrtForList.fromJson(item));
        }
        return APIResponseHibah<List<SrtForList>>(data: srtList);
      }
    }).catchError(
      (_) => APIResponseHibah<SrtForList>(
        error: true,
        errorMessage: 'Terjadi Kesalahan, Silahkan Muat Kembali',
        status: 500,
      ),
    );
  }
}
