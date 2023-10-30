class AgendaRapatModel {
  String idAgenda;
  String slug;
  String idAdmin;
  String idInstansi;
  String namaInstansi;
  String kodeRapat;
  String agendaRapat;
  String tempat;
  String tanggal;
  String jam;
  String deskripsi;
  String linkRapat;
  dynamic createdAt;

  AgendaRapatModel({
    required this.idAgenda,
    required this.slug,
    required this.idAdmin,
    required this.idInstansi,
    required this.namaInstansi,
    required this.kodeRapat,
    required this.agendaRapat,
    required this.tempat,
    required this.tanggal,
    required this.jam,
    required this.deskripsi,
    required this.linkRapat,
    required this.createdAt,
  });

  factory AgendaRapatModel.fromJson(Map<String, dynamic> json) =>
      AgendaRapatModel(
        idAgenda: json["id_agenda"],
        slug: json["slug"],
        idAdmin: json["id_admin"],
        idInstansi: json["id_instansi"],
        namaInstansi: json["nama_instansi"],
        kodeRapat: json["kode_rapat"],
        agendaRapat: json["agenda_rapat"],
        tempat: json["tempat"],
        tanggal: json["tanggal"],
        jam: json["jam"],
        deskripsi: json["deskripsi"],
        linkRapat: json["link_rapat"],
        createdAt: json["created_at"],
      );
}
