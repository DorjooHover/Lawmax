
import 'package:lawmax/data/data.dart';

class Rating {
  ClientId? clientId;
  String? comment;
  double? rating;

  Rating({this.clientId, this.comment, this.rating});

  Rating.fromJson(Map<String, dynamic> json) {
    clientId =
        json['client'] != null ? ClientId.fromJson(json['clientId']) : null;
    comment = json['comment'];
    rating = double.parse(json['rating'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientId'] = clientId;
    data['comment'] = comment;
    data['rating'] = rating;
    return data;
  }
}
