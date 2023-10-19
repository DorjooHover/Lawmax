

class Time {
  String? sId;
  String? lawyer;

  String? service;
  List<TimeType>? serviceType;
  List<TimeDetail>? timeDetail;

  Time(
      {this.sId,
      this.lawyer,

      this.service,
      this.serviceType,
      this.timeDetail});

  Time.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lawyer = json['lawyer'];

    service = json['service'];
    if (json['serviceType'] != null) {
      serviceType = <TimeType>[];
      json['serviceType'].forEach((v) {
        serviceType!.add(TimeType.fromJson(v));
      });
    }
    if (json['timeDetail'] != null) {
      timeDetail = <TimeDetail>[];
      json['timeDetail'].forEach((v) {
        timeDetail!.add(TimeDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['lawyer'] = lawyer;
    data['service'] = service;
    data['serviceType'] = serviceType;
    if (timeDetail != null) {
      data['timeDetail'] = timeDetail!.map((v) => v.toJson()).toList();
    }
    if (serviceType != null) {
      data['serviceType'] = serviceType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeDetail {
  String? status;
  int? time;

  TimeDetail({this.status, this.time});

  TimeDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['time'] = time;
    return data;
  }
}

class TimeType {
  String? type;
  int? price;
  int? expiredTime;

  TimeType({this.type, this.price, this.expiredTime});

  TimeType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
    expiredTime = json['expiredTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    data['expiredTime'] = expiredTime;
    return data;
  }
}

class SortedTime {
 
  int? day;
  List<int>? time;

  SortedTime({ this.day, this.time});

  SortedTime.fromJson(Map<String, dynamic> json) {
 
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['day'] = day;
    data['time'] = time;
    return data;
  }
}
