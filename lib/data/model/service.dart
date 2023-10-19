class Service {
  String? sId;
  String? title;
  String? img;
  String? parentId;

  Service({this.sId, this.title, this.img, this.parentId});

  Service.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    img = json['img'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['img'] = img;
    data['parentId'] = parentId;
    return data;
  }
}

class SubService {
  String? sId;
  String? title;
  ParentId? parentId;
  String? img;
  String? description;

  SubService({this.sId, this.title, this.parentId, this.img, this.description});

  SubService.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    parentId = json['parentId'] != null
        ?  ParentId.fromJson(json['parentId'])
        : null;
    img = json['img'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    if (parentId != null) {
      data['parentId'] = parentId!.toJson();
    }
    data['img'] = img;
    data['description'] = description;
    return data;
  }
}

class ParentId {
  String? sId;
  String? title;

  ParentId({this.sId, this.title});

  ParentId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    return data;
  }
}
