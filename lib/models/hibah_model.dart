class HibahForList {
  String uslIdEx;
  String orgNama;
  String anggaran;
  String uslHsl;
  String uslNm;
  String uslOrg;
  String uslSls;

  int no;
  HibahForList({
    required this.uslIdEx,
    required this.orgNama,
    required this.anggaran,
    required this.uslHsl,
    required this.no,
    required this.uslNm,
    required this.uslOrg,
    required this.uslSls,
  });
  factory HibahForList.fromJson(Map<String, dynamic> item) {
    return HibahForList(
      uslIdEx: item['usl_id_ex'],
      orgNama: item['org_nm'],
      anggaran: item['anggaran'],
      uslHsl: item['usl_hsl'],
      no: item['no'],
      uslNm: item['usl_nm'],
      uslOrg: item['usl_org'],
      uslSls: item['usl_sls'],
    );
  }
}

class PgwForList {
  String pgwIdEx;
  String pgwNm;
  String pgwNip;
  String pgwJbt;
  String pgwGol;
  int no;
  PgwForList(
      {required this.pgwIdEx,
      required this.pgwNm,
      required this.pgwNip,
      required this.pgwJbt,
      required this.no,
      required this.pgwGol});
  factory PgwForList.fromJson(Map<String, dynamic> item) {
    return PgwForList(
      pgwIdEx: item['pgw_id_ex'],
      pgwNm: item['pgw_nm'],
      pgwNip: item['pgw_nip'],
      pgwJbt: item['pgw_jbt'],
      no: item['no'],
      pgwGol: item['pgw_gol'],
    );
  }
}

class Hibah {
  String uslIdEx;
  String uslNm;
  String uslLb;
  String uslTtp;
  String uslOrg;
  String uslT;
  String uslThn;
  String uslSls;
  String orgNm;
  String anggaran;
  String anggaranAlt;
  String uslHsl;
  String uslHslAlt;

  Hibah({
    required this.uslIdEx,
    required this.uslNm,
    required this.uslLb,
    required this.uslTtp,
    required this.uslOrg,
    required this.uslT,
    required this.uslThn,
    required this.uslSls,
    required this.orgNm,
    required this.anggaran,
    required this.anggaranAlt,
    required this.uslHsl,
    required this.uslHslAlt,
  });
  factory Hibah.fromJson(Map<String, dynamic> item) {
    return Hibah(
      uslIdEx: item['usl_id_ex'],
      uslNm: item['usl_nm'],
      uslLb: item['usl_lb'],
      uslTtp: item['usl_ttp'],
      uslOrg: item['usl_org'],
      uslT: item['usl_t'],
      uslThn: item['usl_thn'],
      uslSls: item['usl_sls'],
      orgNm: item['org_nm'],
      anggaran: item['anggaran'],
      anggaranAlt: item['anggaranAlt'],
      uslHsl: item['usl_hsl'],
      uslHslAlt: item['usl_hslAlt'],
    );
  }
}

class UslBrks {
  String uslBrksUsl;
  String uslBrksFl;
  String brksNm;
  int no;
  UslBrks({
    required this.brksNm,
    required this.no,
    required this.uslBrksFl,
    required this.uslBrksUsl,
  });
  factory UslBrks.fromJson(Map<String, dynamic> item) {
    return UslBrks(
      brksNm: item['brks_nm'],
      no: item['no'],
      uslBrksFl: item['uslbrks_fl'],
      uslBrksUsl: item['uslbrks_usl'],
    );
  }
}

class UslA {
  String uslAUsl;
  String uslAU;
  String uslAV;
  String uslAS;
  String uslAStn;
  String uslAHrg;
  String uslANS;
  int no;
  UslA({
    required this.no,
    required this.uslAUsl,
    required this.uslAU,
    required this.uslAV,
    required this.uslAS,
    required this.uslAStn,
    required this.uslANS,
    required this.uslAHrg,
  });
  factory UslA.fromJson(Map<String, dynamic> item) {
    return UslA(
      no: item['no'],
      uslAUsl: item['usla_usl'],
      uslAU: item['usla_u'],
      uslAV: item['usla_v'],
      uslAS: item['usla_s'],
      uslAStn: item['usla_stn'],
      uslANS: item['nusla_s'],
      uslAHrg: item['ttlHrg'],
    );
  }
}

class UslM {
  String uslMT;
  int no;
  UslM({required this.uslMT, required this.no});
  factory UslM.fromJson(Map<String, dynamic> item) {
    return UslM(uslMT: item['uslm_t'], no: item['no']);
  }
}

class UslT {
  String uslTT;
  int no;
  UslT({required this.uslTT, required this.no});
  factory UslT.fromJson(Map<String, dynamic> item) {
    return UslT(uslTT: item['uslt_t'], no: item['no']);
  }
}

class UslThp {
  String uslThpIdEx;
  String uslThpNm;
  String uslThpTglM;
  String uslThpTglMAlt;
  String uslThpTglA;
  String uslThpKet;
  String uslThpJns;
  int no;
  UslThp({
    required this.uslThpIdEx,
    required this.uslThpNm,
    required this.uslThpTglM,
    required this.uslThpTglMAlt,
    required this.uslThpTglA,
    required this.uslThpKet,
    required this.uslThpJns,
    required this.no,
  });
  factory UslThp.fromJson(Map<String, dynamic> item) {
    return UslThp(
      uslThpIdEx: item['thp_id_ex'],
      uslThpNm: item['thp_nm'],
      uslThpTglM: item['uslthp_tglm'],
      uslThpTglMAlt: item['uslthp_tglmAlt'],
      uslThpTglA: item['uslthp_tgla'],
      uslThpKet: item['uslthp_ket'],
      uslThpJns: item['uslthp_jns'],
      no: item['no'],
    );
  }
}

class UslGmbr {
  String uslGmbrIdEx;
  String uslGmbrUsl;
  String uslGmbrNm;
  String uslGmbrFl;
  int no;
  UslGmbr({
    required this.uslGmbrIdEx,
    required this.uslGmbrUsl,
    required this.uslGmbrNm,
    required this.uslGmbrFl,
    required this.no,
  });
  factory UslGmbr.fromJson(Map<String, dynamic> item) {
    return UslGmbr(
      uslGmbrIdEx: item['uslgmbr_id_ex'],
      uslGmbrUsl: item['uslgmbr_usl'],
      uslGmbrNm: item['uslgmbr_nm'],
      uslGmbrFl: item['uslgmbr_fl'],
      no: item['no'],
    );
  }
}

class UslBa {
  String uslBaIdEx;
  String uslBaUsl;
  String uslBaNm;
  String uslBaFl;
  int no;
  UslBa({
    required this.uslBaIdEx,
    required this.uslBaUsl,
    required this.uslBaNm,
    required this.uslBaFl,
    required this.no,
  });
  factory UslBa.fromJson(Map<String, dynamic> item) {
    return UslBa(
      uslBaIdEx: item['uslba_id_ex'],
      uslBaUsl: item['uslba_usl'],
      uslBaNm: item['uslba_nm'],
      uslBaFl: item['uslba_fl'],
      no: item['no'],
    );
  }
}

class UslVer {
  String uslVerIdEx;
  String pgwNm;
  String pgwJbt;
  String uslVerP;
  int no;
  UslVer({
    required this.uslVerIdEx,
    required this.pgwNm,
    required this.pgwJbt,
    required this.uslVerP,
    required this.no,
  });
  factory UslVer.fromJson(Map<String, dynamic> item) {
    return UslVer(
      uslVerIdEx: item['uslver_id_ex'],
      pgwNm: item['pgw_nm'],
      pgwJbt: item['pgw_jbt'],
      uslVerP: item['uslver_p'],
      no: item['no'],
    );
  }
}

class UslInb {
  String inbIdEx;
  String inbJdl;
  String inbUsl;
  String inbTgl;
  String inbJam;
  int no;
  UslInb({
    required this.inbIdEx,
    required this.inbJdl,
    required this.inbUsl,
    required this.inbTgl,
    required this.inbJam,
    required this.no,
  });
  factory UslInb.fromJson(Map<String, dynamic> item) {
    return UslInb(
      inbIdEx: item['inb_id_ex'],
      inbJdl: item['inb_jdl'],
      inbUsl: item['inb_usl'],
      inbTgl: item['inb_tgl'],
      inbJam: item['inb_jam'],
      no: item['no'],
    );
  }
}

class Anggaran {
  String anggaran;
  String anggaranb;

  Anggaran({required this.anggaran, required this.anggaranb});

  factory Anggaran.fromJson(Map<String, dynamic> item) {
    return Anggaran(
      anggaran: item['anggaran'],
      anggaranb: item['anggaranb'],
    );
  }
}

class AnggaranStj {
  String anggaran;
  String anggaranb;

  AnggaranStj({required this.anggaran, required this.anggaranb});

  factory AnggaranStj.fromJson(Map<String, dynamic> item) {
    return AnggaranStj(
      anggaran: item['anggaran'],
      anggaranb: item['anggaranb'],
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

class PengOrganisasiForList {
  String pengIdEx;
  String pengNm;
  String pengJk;
  String pengHp;
  String strNm;
  String pengNik;
  String pengPicKtp;
  String pengPic;

  int no;
  PengOrganisasiForList({
    required this.pengIdEx,
    required this.pengNm,
    required this.pengJk,
    required this.pengHp,
    required this.strNm,
    required this.pengNik,
    required this.pengPicKtp,
    required this.pengPic,
    required this.no,
  });
  factory PengOrganisasiForList.fromJson(Map<String, dynamic> item) {
    return PengOrganisasiForList(
      pengIdEx: item['peng_id_ex'],
      pengNm: item['peng_nm'],
      pengJk: item['peng_jkAlt'],
      pengHp: item['peng_telp'],
      strNm: item['str_nm'],
      pengNik: item['peng_nik'],
      pengPicKtp: item['peng_ktp'],
      pengPic: item['peng_pic'],
      no: item['no'],
    );
  }
}

class SrtForList {
  String srtIdEx;
  String srtNm;

  int no;
  SrtForList({
    required this.srtIdEx,
    required this.srtNm,
    required this.no,
  });
  factory SrtForList.fromJson(Map<String, dynamic> item) {
    return SrtForList(
      srtIdEx: item['srt_id_ex'],
      srtNm: item['srt_nm'],
      no: item['no'],
    );
  }
}
