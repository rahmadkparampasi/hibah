// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:SimhegaM/constants/var_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

class HibahService {
  Future<APIResponseMasuk<FeedBackMasuk>> masuk(CheckMasuk masuk) {
    Uri newApiUrl = Uri.parse('$apiURL/msk/authMasukM');
    return http.post(newApiUrl, body: masuk.toJson()).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseMasuk<FeedBackMasuk>(
          data: FeedBackMasuk.fromJson(jsonData),
          status: data.statusCode,
          dialog: (jsonData['type'] == "info")
              ? DialogType.INFO
              : (jsonData['type'] == "warning")
                  ? DialogType.WARNING
                  : DialogType.SUCCES,
        );
      } else {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseMasuk<FeedBackMasuk>(
          error: true,
          data: FeedBackMasuk.fromJson(jsonData),
          errorMessage: 'Terjadi Kesalahan',
          status: jsonData.statusCode,
          dialog: DialogType.ERROR,
        );
      }
    }).catchError((_) => APIResponseMasuk<FeedBackMasuk>(
          error: true,
          errorMessage: 'Terjadi Kesalahan',
          dialog: DialogType.ERROR,
        ));
  }

  Future<APIResponseHibah<List<HibahForList>>> getHibahListPage() {
    Uri newApiUrl = Uri.parse('$apiURL/homemobm/getUsl');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final hibahList = <HibahForList>[];
        for (var item in jsonData) {
          hibahList.add(HibahForList.fromJson(item));
        }
        return APIResponseHibah<List<HibahForList>>(data: hibahList);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final hibahList = <HibahForList>[];
        for (var item in jsonData) {
          hibahList.add(HibahForList.fromJson(item));
        }
        return APIResponseHibah<List<HibahForList>>(data: hibahList);
      }
    }).catchError(
      (_) => APIResponseHibah<HibahForList>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<HibahForList>>> getHibahSlsListPage() {
    Uri newApiUrl = Uri.parse('$apiURL/homemobm/getUslSls');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final hibahList = <HibahForList>[];
        for (var item in jsonData) {
          hibahList.add(HibahForList.fromJson(item));
        }
        return APIResponseHibah<List<HibahForList>>(data: hibahList);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final hibahList = <HibahForList>[];
        for (var item in jsonData) {
          hibahList.add(HibahForList.fromJson(item));
        }
        return APIResponseHibah<List<HibahForList>>(data: hibahList);
      }
    }).catchError(
      (_) => APIResponseHibah<HibahForList>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }
}
