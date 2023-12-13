class AgendaRapatSelesaiModel {
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
  bool hadir;
  dynamic createdAt;

  AgendaRapatSelesaiModel({
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
    required this.hadir,
    required this.createdAt,
  });

  factory AgendaRapatSelesaiModel.fromJson(Map<String, dynamic> json) =>
      AgendaRapatSelesaiModel(
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
        hadir: json["hadir"],
        createdAt: json["created_at"],
      );
}
