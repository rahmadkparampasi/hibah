class HibahForList {
  String orgNama;
  String anggaran;
  String uslHsl;
  String uslNm;
  int no;
  HibahForList({
    required this.orgNama,
    required this.anggaran,
    required this.uslHsl,
    required this.no,
    required this.uslNm,
  });
  factory HibahForList.fromJson(Map<String, dynamic> item) {
    return HibahForList(
      orgNama: item['org_nm'],
      anggaran: item['anggaran'],
      uslHsl: item['usl_hsl'],
      no: item['no'],
      uslNm: item['usl_nm'],
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
