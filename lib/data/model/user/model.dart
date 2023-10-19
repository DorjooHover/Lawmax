

import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? phone;
  UserTypes? userType;
  List<Experiences>? experiences;
  List<Education>? education;
  String? degree;
  List<Rating>? rating;
  String? userStatus;
  int? alert;
  double? ratingAvg;
  List<String>? userServices;
  String? createdAt;
  String? updatedAt;
  Account? account;
  String? certificate;
  int? experience;
  String? licenseNumber;
  LocationDto? location;
  LocationDto? officeLocation;
  String? taxNumber;
  String? registerNumber;
  String? profileImg;
  String? email;
  String? workLocationString;
  String? officeLocationString;
  List<String>? phoneNumbers;
  LocationDto? workLocation;

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.phone,
      this.userType,
      this.experiences,
      this.education,
      this.degree,
      this.rating,
      this.userStatus,
      this.alert,
      this.profileImg,
      this.userServices,
      this.createdAt,
      this.workLocationString,
      this.officeLocationString,
      this.updatedAt,
      this.ratingAvg,
      this.account,
      this.certificate,
      this.experience,
      this.licenseNumber,
      this.location,
      this.registerNumber,
      this.officeLocation,
      this.taxNumber,
      this.email,
      this.phoneNumbers,
      this.workLocation});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    userType = json['userType'] == 'lawyer' ? UserTypes.lawyer : 'our' == json['userType'] ? UserTypes.our : UserTypes.user;
    workLocationString = json['workLocationString'];
    officeLocationString = json['officeLocationString'];
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experiences.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(Education.fromJson(v));
      });
    }
    degree = json['degree'];
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating!.add(Rating.fromJson(v));
      });
    }
    if (json['phoneNumbers'] != null) {
      phoneNumbers = <String>[];
      json['phoneNumbers'].forEach((v) {
        phoneNumbers!.add(v.toString());
      });
    }
    userStatus = json['userStatus'];
    email = json['email'];
    alert = json['alert'];
    profileImg = json['profileImg'];
    ratingAvg = double.parse(
        json['ratingAvg'] == null ? '0' : json['ratingAvg'].toString());
    if (json['userServices'] != null) {
      userServices = <String>[];
      json['userServices'].forEach((v) {
        userServices!.add(v.toString());
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    certificate = json['certificate'];
    experience = json['experience'];
    licenseNumber = json['licenseNumber'];
    location = json['location'] != null
        ? LocationDto.fromJson(json['location'])
        : null;
    officeLocation = json['officeLocation'] != null
        ? LocationDto.fromJson(json['officeLocation'])
        : null;
    taxNumber = json['taxNumber'];
    registerNumber = json['registerNumber'];
    workLocation = json['workLocation'] != null
        ? LocationDto.fromJson(json['workLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['userType'] = userType;
    data['officeLocationString'] = officeLocationString;
    data['workLocationString'] = workLocationString;
    if (experiences != null) {
      data['experiences'] = experiences!.map((v) => v.toJson()).toList();
    }
    if (education != null) {
      data['education'] = education!.map((v) => v.toJson()).toList();
    }
    data['degree'] = degree;
    if (rating != null) {
      data['rating'] = rating!.map((v) => v.toJson()).toList();
    }
    data['userStatus'] = userStatus;
    data['alert'] = alert;
    data['profileImg'] = profileImg;
    data['ratingAvg'] = ratingAvg;
    if (userServices != null) {
      data['userServices'] = userServices;
    }
    if (phoneNumbers != null) {
      data['phoneNumbers'] = phoneNumbers;
    }

    data['createdAt'] = createdAt;
    data['email'] = email;
    data['updatedAt'] = updatedAt;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    data['certificate'] = certificate;
    data['experience'] = experience;
    data['licenseNumber'] = licenseNumber;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (officeLocation != null) {
      data['officeLocation'] = officeLocation!.toJson();
    }
    data['taxNumber'] = taxNumber;
    data['registerNumber'] = registerNumber;
    if (workLocation != null) {
      data['workLocation'] = workLocation!.toJson();
    }
    return data;
  }
}

class Account {
  int? accountNumber;
  String? username;
  String? bank;

  Account({this.accountNumber, this.username, this.bank});

  Account.fromJson(Map<String, dynamic> json) {
    accountNumber = json['accountNumber'];
    username = json['username'];
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountNumber'] = accountNumber;
    data['username'] = username;
    data['bank'] = bank;
    return data;
  }
}
