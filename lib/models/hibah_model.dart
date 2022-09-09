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
  String uslOrg;

  Hibah(
      {required this.uslIdEx,
      required this.uslNm,
      required this.uslLb,
      required this.uslTtp,
      required this.uslOrg});
  factory Hibah.fromJson(Map<String, dynamic> item) {
    return Hibah(
      uslIdEx: item['usl_id_ex'],
      uslNm: item['usl_nm'],
      uslLb: item['usl_lb'],
      uslTtp: item['usl_ttp'],
      uslOrg: item['usl_org'],
    );
  }
}

class Organisasi {
  String orgIdEx;
  String riNm;
  String orgNm;
  String orgAlt;
  String orgMail;
  String orgNpwp;
  String orgHp;
  String orgAkt;
  String orgTgl;
  String orgRek;

  Organisasi(
      {required this.orgIdEx,
      required this.riNm,
      required this.orgNm,
      required this.orgAlt,
      required this.orgMail,
      required this.orgNpwp,
      required this.orgHp,
      required this.orgAkt,
      required this.orgTgl,
      required this.orgRek});
  factory Organisasi.fromJson(Map<String, dynamic> item) {
    return Organisasi(
      orgIdEx: item['org_id_ex'],
      riNm: item['ri_nm'],
      orgNm: item['org_nm'],
      orgAlt: item['alamat'],
      orgMail: item['org_mail'],
      orgNpwp: item['org_npwp'],
      orgHp: item['org_hp'],
      orgAkt: item['org_akt'],
      orgTgl: item['org_tgl'],
      orgRek: item['org_rek'],
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
