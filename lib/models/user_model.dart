class UserModel {
  String nip;
  String namaLengkap;
  String kodeUkerja;
  String ketUkerja;
  String ketJab;
  String alamat;
  String noHp;
  String email;

  UserModel({
    required this.nip,
    required this.namaLengkap,
    required this.kodeUkerja,
    required this.ketUkerja,
    required this.ketJab,
    required this.alamat,
    required this.noHp,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nip: json["nip"],
        namaLengkap: json["nama_lengkap"],
        kodeUkerja: json["kode_ukerja"],
        ketUkerja: json["ket_ukerja"],
        ketJab: json["ket_jab"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        email: json["email"],
      );
}
