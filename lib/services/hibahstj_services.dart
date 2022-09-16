import 'dart:convert';

import 'package:SimhegaM/constants/var_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/models/hibahpost_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

class HibahStjService {
  Future<APIResponse<FeedBackUsl>> changeUslT(ChangeUslT uslT) {
    Uri newApiUrl = Uri.parse('$apiURL/usl/changeJnsM');
    return http.post(newApiUrl, body: uslT.toJson()).then((data) {
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
    }).catchError(
      (_) => APIResponse<FeedBackUsl>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        dialog: DialogType.ERROR,
      ),
    );
  }

  Future<APIResponse<FeedBackUsl>> changeStj(String url) {
    Uri newApiUrl = Uri.parse('$apiURL/uslstjm/$url');

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
}
