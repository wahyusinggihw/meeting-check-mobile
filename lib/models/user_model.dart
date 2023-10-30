class UserModel {
  final String idInstansi;
  final String kodeInstansi;
  final String kodeUkerja;
  final String kodeUinduk;
  final String ketUkerja;
  final String ketUorg;
  final String alamatUkerja;
  final String sInduk;
  final String sUkerja;
  final String emailUkerja;
  final String jenisInduk;
  final String sub;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  UserModel({
    required this.idInstansi,
    required this.kodeInstansi,
    required this.kodeUkerja,
    required this.kodeUinduk,
    required this.ketUkerja,
    required this.ketUorg,
    required this.alamatUkerja,
    required this.sInduk,
    required this.sUkerja,
    required this.emailUkerja,
    required this.jenisInduk,
    required this.sub,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idInstansi: json["id_instansi"],
        kodeInstansi: json["kode_instansi"],
        kodeUkerja: json["kode_ukerja"],
        kodeUinduk: json["kode_uinduk"],
        ketUkerja: json["ket_ukerja"],
        ketUorg: json["ket_uorg"],
        alamatUkerja: json["alamat_ukerja"],
        sInduk: json["s_induk"],
        sUkerja: json["s_ukerja"],
        emailUkerja: json["email_ukerja"],
        jenisInduk: json["jenis_induk"],
        sub: json["sub"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}
