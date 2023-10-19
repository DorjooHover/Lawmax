class Education {
  String? link;
  int? date;
  String? title;

  Education({this.link, this.date, this.title});

  Education.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    date = json['date'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['date'] = date;
    data['title'] = title;
    return data;
  }
}
