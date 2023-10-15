class AgendaRapatModel {
  final String? idAgenda;
  final String? idAdmin;
  final String? kodeRapat;
  final String? judulRapat;
  final String? tempat;
  final String? tanggal;
  final String? jam;
  final String? agenda;
  final String? linkRapat;

  AgendaRapatModel({
    required this.idAgenda,
    required this.idAdmin,
    required this.kodeRapat,
    required this.judulRapat,
    required this.tempat,
    required this.tanggal,
    required this.jam,
    required this.agenda,
    required this.linkRapat,
  });

  factory AgendaRapatModel.fromJson(Map<String, dynamic> json) {
    return AgendaRapatModel(
      idAgenda: json['id_agenda'],
      idAdmin: json['id_admin'],
      kodeRapat: json['kode_rapat'],
      judulRapat: json['judul_rapat'],
      tempat: json['tempat'],
      tanggal: json['tanggal'],
      jam: json['jam'],
      agenda: json['agenda'],
      linkRapat: json['link_rapat'],
    );
  }
}
