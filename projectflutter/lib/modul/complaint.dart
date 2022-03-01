import 'dart:convert';

List<Complaints> complaintsFromJson(String str) =>
    List<Complaints>.from(json.decode(str).map((x) => Complaints.fromJson(x)));

String complaintsToJson(List<Complaints> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Complaints {
  Complaints({
    required this.idComplaint,
    required this.idCust,
    required this.complaintDetail,
    this.handleByCsId,
    this.handleByTekId,
    required this.dateReceive,
    this.dateEst,
    this.dateFinish,
    required this.status,
    this.image,
  });

  String idComplaint;
  String idCust;
  String complaintDetail;
  dynamic handleByCsId;
  dynamic handleByTekId;
  DateTime dateReceive;
  dynamic dateEst;
  dynamic dateFinish;
  String status;
  dynamic image;

  factory Complaints.fromJson(Map<String, dynamic> json) => Complaints(
        idComplaint: json["id_complaint"],
        idCust: json["id_cust"],
        complaintDetail: json["complaint_detail"],
        handleByCsId: json["handle_by_cs_id"],
        handleByTekId: json["handle_by_tek_id"],
        dateReceive: DateTime.parse(json["date_receive"]),
        dateEst: json["date_est"],
        dateFinish: json["date_finish"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id_complaint": idComplaint,
        "id_cust": idCust,
        "complaint_detail": complaintDetail,
        "handle_by_cs_id": handleByCsId,
        "handle_by_tek_id": handleByTekId,
        "date_receive":
            "${dateReceive.year.toString().padLeft(4, '0')}-${dateReceive.month.toString().padLeft(2, '0')}-${dateReceive.day.toString().padLeft(2, '0')}",
        "date_est": dateEst,
        "date_finish": dateFinish,
        "status": status,
        "image": image,
      };
}
