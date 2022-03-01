import 'complaint.dart';
import 'package:http/http.dart' as http;

Future<List<Complaints>> fetchComplaints() async {
  String url = "https://sdarrahman.000webhostapp.com/get_complaint_list.php";
  final response = await http.get(Uri.parse(url));
  return complaintsFromJson(response.body);
}
