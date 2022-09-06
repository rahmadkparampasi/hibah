class HibahForList {
  String uslIdEx;
  String orgNama;
  String anggaran;
  String uslHsl;
  String uslNm;
  int no;
  HibahForList({
    required this.uslIdEx,
    required this.orgNama,
    required this.anggaran,
    required this.uslHsl,
    required this.no,
    required this.uslNm,
  });
  factory HibahForList.fromJson(Map<String, dynamic> item) {
    return HibahForList(
      uslIdEx: item['usl_id_ex'],
      orgNama: item['org_nm'],
      anggaran: item['anggaran'],
      uslHsl: item['usl_hsl'],
      no: item['no'],
      uslNm: item['usl_nm'],
    );
  }
}

class Hibah {
  String uslIdEx;
  String uslNm;
  String uslLb;
  String uslTtp;
  Hibah({
    required this.uslIdEx,
    required this.uslNm,
    required this.uslLb,
    required this.uslTtp,
  });
  factory Hibah.fromJson(Map<String, dynamic> item) {
    return Hibah(
      uslIdEx: item['usl_id_ex'],
      uslNm: item['usl_nm'],
      uslLb: item['usl_lb'],
      uslTtp: item['usl_ttp'],
    );
  }
}

class CheckMasuk {
  String user;
  String pass;

  CheckMasuk({required this.user, required this.pass});

  Map<String, dynamic> toJson() {
    return {"user": user, "pass": pass};
  }
}

class FeedBackMasuk {
  String token;
  String message;
  String response;
  String type;
  FeedBackMasuk(
      {required this.token,
      required this.message,
      required this.response,
      required this.type});

  factory FeedBackMasuk.fromJson(Map<String, dynamic> item) {
    return FeedBackMasuk(
      token: item['token'],
      message: item['message'],
      type: item['type'],
      response: item['response'],
    );
  }
}
