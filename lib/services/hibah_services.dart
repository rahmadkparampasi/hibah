import 'dart:convert';

import 'package:SimhegaM/constants/var_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/models/hibahpost_model.dart';
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
        errorMessage: 'Terjadi Kesalahan, Silahkan Muat Kembali',
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

  Future<APIResponseHibah<Hibah>> getHibah(String uslIdEx) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/viewData/$uslIdEx');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];

        return APIResponseHibah<Hibah>(data: Hibah.fromJson(jsonData));
      } else {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseHibah<Hibah>(
          error: true,
          errorMessage: 'Terjadi Masalah',
          data: Hibah.fromJson(jsonData),
        );
      }
    }).catchError((_) => APIResponseHibah<Hibah>(
        error: true, errorMessage: 'Terjadi Kesalahan'));
  }

  Future<APIResponseOrganisasi<Organisasi>> getOrganisasi(String orgIdEx) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/viewOrg/$orgIdEx');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseOrganisasi<Organisasi>(
          data: Organisasi.fromJson(jsonData),
        );
      } else {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseOrganisasi<Organisasi>(
          error: true,
          errorMessage: 'Terjadi Kesalahan',
          data: Organisasi.fromJson(jsonData),
        );
      }
    }).catchError((_) => APIResponseOrganisasi<Organisasi>(
        error: true, errorMessage: 'Terjadi Kesalahan'));
  }

  Future<APIResponsePengOrganisasi<List<PengOrganisasiForList>>>
      getPengOrganisasiList(String pengOrg) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/viewPengOrg/$pengOrg');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final pengOrganisasiList = <PengOrganisasiForList>[];
        for (var item in jsonData) {
          pengOrganisasiList.add(PengOrganisasiForList.fromJson(item));
        }
        return APIResponsePengOrganisasi<List<PengOrganisasiForList>>(
            data: pengOrganisasiList);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final pengOrganisasiList = <PengOrganisasiForList>[];
        for (var item in jsonData) {
          pengOrganisasiList.add(PengOrganisasiForList.fromJson(item));
        }
        return APIResponsePengOrganisasi<List<PengOrganisasiForList>>(
            data: pengOrganisasiList);
      }
    }).catchError(
      (_) => APIResponsePengOrganisasi<PengOrganisasiForList>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<UslBrks>>> getUslBrks(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslbkrsByUsl/$usl');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslBrksList = <UslBrks>[];
        for (var item in jsonData) {
          uslBrksList.add(UslBrks.fromJson(item));
        }
        return APIResponseHibah<List<UslBrks>>(data: uslBrksList);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslBrksList = <UslBrks>[];
        for (var item in jsonData) {
          uslBrksList.add(UslBrks.fromJson(item));
        }
        return APIResponseHibah<List<UslBrks>>(data: uslBrksList);
      }
    }).catchError((_) => APIResponseHibah<UslBrks>(
        error: true, errorMessage: 'Terjadi Kesalahan', status: 500));
  }

  Future<APIResponseHibah<List<UslA>>> getUslA(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslaByUsl/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslA = <UslA>[];
        for (var item in jsonData) {
          uslA.add(UslA.fromJson(item));
        }
        return APIResponseHibah<List<UslA>>(data: uslA);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslA = <UslA>[];
        for (var item in jsonData) {
          uslA.add(UslA.fromJson(item));
        }
        return APIResponseHibah<List<UslA>>(data: uslA);
      }
    }).catchError(
      (_) => APIResponseHibah<UslA>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<Anggaran>> getAnggaran(String uslIdEx) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/hitungAnggaran/$uslIdEx');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseHibah<Anggaran>(
          data: Anggaran.fromJson(jsonData),
        );
      } else {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseHibah<Anggaran>(
          error: true,
          errorMessage: 'Terjadi Kesalahan',
          data: Anggaran.fromJson(jsonData),
        );
      }
    }).catchError(
      (_) => APIResponseHibah<Anggaran>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
      ),
    );
  }

  Future<APIResponseHibah<AnggaranStj>> getAnggaranStj(String uslIdEx) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/hitungAnggaran/$uslIdEx');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseHibah<AnggaranStj>(
          data: AnggaranStj.fromJson(jsonData),
        );
      } else {
        final jsonData = json.decode(data.body)['response'];
        return APIResponseHibah<AnggaranStj>(
          error: true,
          errorMessage: 'Terjadi Kesalahan',
          data: AnggaranStj.fromJson(jsonData),
        );
      }
    }).catchError(
      (_) => APIResponseHibah<AnggaranStj>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
      ),
    );
  }

  Future<APIResponseHibah<List<UslM>>> getUslM(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslmByUsl/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslM = <UslM>[];
        for (var item in jsonData) {
          uslM.add(UslM.fromJson(item));
        }
        return APIResponseHibah<List<UslM>>(data: uslM);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslM = <UslM>[];
        for (var item in jsonData) {
          uslM.add(UslM.fromJson(item));
        }
        return APIResponseHibah<List<UslM>>(data: uslM);
      }
    }).catchError(
      (_) => APIResponseHibah<UslM>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<UslT>>> getUslT(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUsltByUsl/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslT = <UslT>[];
        for (var item in jsonData) {
          uslT.add(UslT.fromJson(item));
        }
        return APIResponseHibah<List<UslT>>(data: uslT);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslT = <UslT>[];
        for (var item in jsonData) {
          uslT.add(UslT.fromJson(item));
        }
        return APIResponseHibah<List<UslT>>(data: uslT);
      }
    }).catchError(
      (_) => APIResponseHibah<UslT>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<UslThp>>> getUslThp(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslThp/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslThp = <UslThp>[];
        for (var item in jsonData) {
          uslThp.add(UslThp.fromJson(item));
        }
        return APIResponseHibah<List<UslThp>>(data: uslThp);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslThp = <UslThp>[];
        for (var item in jsonData) {
          uslThp.add(UslThp.fromJson(item));
        }
        return APIResponseHibah<List<UslThp>>(data: uslThp);
      }
    }).catchError(
      (_) => APIResponseHibah<UslThp>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<UslGmbr>>> getUslGmbr(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslGmbr/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslGmbr = <UslGmbr>[];
        for (var item in jsonData) {
          uslGmbr.add(UslGmbr.fromJson(item));
        }
        return APIResponseHibah<List<UslGmbr>>(data: uslGmbr);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslGmbr = <UslGmbr>[];
        for (var item in jsonData) {
          uslGmbr.add(UslGmbr.fromJson(item));
        }
        return APIResponseHibah<List<UslGmbr>>(data: uslGmbr);
      }
    }).catchError(
      (_) => APIResponseHibah<UslGmbr>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<UslBa>>> getUslBa(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslBa/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslBa = <UslBa>[];
        for (var item in jsonData) {
          uslBa.add(UslBa.fromJson(item));
        }
        return APIResponseHibah<List<UslBa>>(data: uslBa);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslBa = <UslBa>[];
        for (var item in jsonData) {
          uslBa.add(UslBa.fromJson(item));
        }
        return APIResponseHibah<List<UslBa>>(data: uslBa);
      }
    }).catchError(
      (_) => APIResponseHibah<UslBa>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<UslVer>>> getUslVer(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslVer/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslVer = <UslVer>[];
        for (var item in jsonData) {
          uslVer.add(UslVer.fromJson(item));
        }
        return APIResponseHibah<List<UslVer>>(data: uslVer);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslVer = <UslVer>[];
        for (var item in jsonData) {
          uslVer.add(UslVer.fromJson(item));
        }
        return APIResponseHibah<List<UslVer>>(data: uslVer);
      }
    }).catchError(
      (_) => APIResponseHibah<UslVer>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

  Future<APIResponseHibah<List<UslInb>>> getUslInb(String usl) {
    Uri newApiUrl = Uri.parse('$apiURL/uslvm/getUslInb/$usl');
    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final uslInb = <UslInb>[];
        for (var item in jsonData) {
          uslInb.add(UslInb.fromJson(item));
        }
        return APIResponseHibah<List<UslInb>>(data: uslInb);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final uslInb = <UslInb>[];
        for (var item in jsonData) {
          uslInb.add(UslInb.fromJson(item));
        }
        return APIResponseHibah<List<UslInb>>(data: uslInb);
      }
    }).catchError(
      (_) => APIResponseHibah<UslInb>(
        error: true,
        errorMessage: 'Terjadi Kesalahan',
        status: 500,
      ),
    );
  }

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

  Future<APIResponseHibah<List<PgwForList>>> getPgwListPage() {
    Uri newApiUrl = Uri.parse('$apiURL/pgw/getAllM');

    return http.get(newApiUrl).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body)['response'];
        final pgwList = <PgwForList>[];
        for (var item in jsonData) {
          pgwList.add(PgwForList.fromJson(item));
        }
        return APIResponseHibah<List<PgwForList>>(data: pgwList);
      } else {
        final jsonData = json.decode(data.body)['response'];
        final pgwList = <PgwForList>[];
        for (var item in jsonData) {
          pgwList.add(PgwForList.fromJson(item));
        }
        return APIResponseHibah<List<PgwForList>>(data: pgwList);
      }
    }).catchError(
      (_) => APIResponseHibah<PgwForList>(
        error: true,
        errorMessage: 'Terjadi Kesalahan, Silahkan Muat Kembali',
        status: 500,
      ),
    );
  }

  Future<APIResponse<FeedBackUsl>> insertUslVer(InsertUslVer uslVer) {
    Uri newApiUrl = Uri.parse('$apiURL/uslver/insertDataM');
    return http.post(newApiUrl, body: uslVer.toJson()).then((data) {
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

  Future<APIResponse<FeedBackUsl>> uslVerDelete(String uslVerIdEx) {
    Uri newApiUrl = Uri.parse('$apiURL/uslver/deleteDataM/$uslVerIdEx');
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

  Future<APIResponse<FeedBackUsl>> insertInb(InsertInb uslInb) {
    Uri newApiUrl = Uri.parse('$apiURL/inb/addSrtM');
    return http.post(newApiUrl, body: uslInb.toJson()).then((data) {
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
}
