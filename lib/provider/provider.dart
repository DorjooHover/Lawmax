
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/constants/constants.dart';
import 'package:lawmax/config/config.dart' as config;
import 'dart:developer' as dev;
typedef EitherUser<T> = Future<Either<String, User>>;
typedef EitherToken<T> = Future<Either<String, String>>;
typedef EitherSuccess<T> = Future<Either<String, bool>>;
typedef EitherTime<T> = Future<Either<String, Time>>;
typedef EitherBook<T> = Future<Either<String, Book>>;
typedef EitherLocation<T> = Future<Either<String, LocationDto>>;
// lists
typedef EitherListSubService<T> = Future<Either<String, List<SubService>>>;
typedef EitherListUser<T> = Future<Either<String, List<User>>>;
typedef EitherListTime<T> = Future<Either<String, List<Time>>>;
typedef EitherListService<T> = Future<Either<String, List<Service>>>;
typedef EitherListBook<T> = Future<Either<String, List<Book>>>;

class ApiRepository extends GetxService {
  final isProduction = const bool.fromEnvironment('dart.vm.product');
  var dio = createDio();
  static var storage = GetStorage();
  final token = storage.read(StorageKeys.token.name);
  static Dio createDio() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://lawyernestjs-production.up.railway.app',
    ));
    dio.interceptors.addAll(
      [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // get token from storage
            final token = storage.read(StorageKeys.token.name);

            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {}
            return handler.next(options);
          },
        ),
        // RetryOnConnectionChangeInterceptor()
        // LogInterceptor(responseBody: true),
      ],
    );
    return dio;
  }

  EitherToken<String> login(String phone, String password) async {
    try {
      final data = {"phone": phone, "password": password};
      
      final res = await dio.post('/auth/login', data: data);
      
  

      if(res.statusCode == 201) {
        return right(res.data['token'] as String);
      }
      return left(res.data['message']);
    } catch (e) {
    
      return left(e.toString());
    }
  }

  EitherToken<String> register(
      String phone, String password, String firstName, String lastName) async {

        try {
    final data = {
      "phone": phone,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "userType": "lawyer"
    };
    final res = await dio.post('/auth/register', data: data);
    if(res.statusCode == 201) {
        return right(res.data['token']);
      }
      return left(res.data['message']);
    } catch (e) {
    
      return left(e.toString());
    }
  }

// user
 EitherUser<User> getUser() async {
    try {
      final res = await dio.get('/user/me');
      if(res.statusCode == 200) {
  
        return right(User.fromJson(res.data));
      }
      
      
      return left("Нэвтрэнэ үү.");
    } catch (e) {
      return left(e.toString());
    }
  }
  EitherListUser<List<User>>suggestedLawyers() async {
    try {
      final res = await dio.get('/user/suggest/lawyer');
       if(res.statusCode == 200) {
      return right(    (res.data as List).map((e) => User.fromJson(e)).toList());
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

  EitherListUser<List<User>> suggestedLawyersByCategory(
      String id, String cateId) async {
    try {
      final res = await dio.get('/user/suggest/lawyer/$id/$cateId');
      if(res.statusCode == 200) {
      return right(    (res.data as List).map((e) => User.fromJson(e)).toList());
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

 EitherSuccess<bool> sendRating(
    String id,
    double rate,
    String comment,
  ) async {
    try {
      final data = {
        "rating": rate,
        "message": comment,
      };

     final res =  await dio.post('/user/$id', data: data);

     if(res.statusCode == 201) {
        return right(true);
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }
  EitherSuccess<bool> updateLawyer(User user) async {
    try {
      final data = {
        'experience': user.experience,
        'education': user.education,
        'degree': user.degree,
        'account': user.account,
        'licenseNumber': user.licenseNumber,
        'location': user.location,
        'certificate': user.certificate,
        'taxNumber': user.taxNumber,
        'workLocation': user.workLocation,
        'officeLocation': user.officeLocation,
        'experiences': user.experiences,
        'registerNumber': user.registerNumber,
        'userServices': user.userServices,
        'workLocationString': user.workLocationString,
        'officeLocationString': user.officeLocationString,
        'email': user.email,
        'phoneNumbers': user.phoneNumbers,
        'profileImg': user.profileImg ?? '',
      };
      final res = await dio.patch('/user', data: data);

     if(res.statusCode == 201) {
        return right(true);
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

  EitherLocation<LocationDto> getLawyerLocation(String id) async {
    try {
      final res = await dio.get(
        '/user/lawyer/location/$id',
      );
     
      if(res.statusCode == 200) {
        return right(LocationDto.fromJson(res.data));
      }
      return left(res.data);
    } catch (e) {
      return left(e.toString());
    }
  }

  
  EitherSuccess<bool> updateLawyerLocation(LocationDto location) async {
    try {
      final data = {
        "lat": location.lat,
        "lng": location.lng,
      };
      final res = await dio.patch('/user/location', data: data);

      if(res.statusCode == 201) {
        return right(true);
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }
// service
  EitherListService<List<Service>> servicesList() async {
    try {
      final res = await dio.get('/service');
      if(res.statusCode == 200) {
        return right((res.data as List).map((e) => Service.fromJson(e)).toList());
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

 EitherListSubService<List<SubService>> subServiceList(String id) async {
    try {
      final res = await dio.get('/service/$id');
      if(res.statusCode == 200) {

       return right(   (res.data as List).map((e) => SubService.fromJson(e)).toList());
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

  // agora token 
  EitherToken<String> getAgoraToken(String channelName, int uid) async {
    try {
      final res = await Dio().get(
          "${config.agoraUrl}/$channelName/publisher/uid/$uid?expiry=9000");
      if(res.statusCode ==  200) {

      return right(res.data["rtcToken"]);
      }

    return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

  // book

  EitherSuccess<bool> createOrder(
    int date,
    String lawyerId,
    int expiredTime,
    int price,
    String serviceType,
    String serviceId,
    String subServiceId,
    LocationDto location,
  ) async {
    try {
      final data = {
        "date": date,

        "lawyerId": lawyerId,
        "serviceId": serviceId,
        "subServiceId": subServiceId,
        "location": location,
        "expiredTime": expiredTime,
        "serviceType": serviceType,
        "serviceStatus": "pending",
        "channelName": DateTime.now().millisecondsSinceEpoch.toString(),

        "price": "$price",
        "lawyerToken": "string",
        "userToken": "string",
      
      };
print(data);
      final res = await dio.post('/order', data: data);
      print(res.data);
      if(res.statusCode == 201) {
        return right(true);
      }
      return left(res.data);
    } catch(e) {
print(e.toString());
      return left(e.toString());
    }
  }

 

  EitherSuccess<bool> createEmergencyOrder(
    int date,
    String lawyerId,
    int expiredTime,
    int price,
    String serviceType,
    String reason,
    LocationDto location,
  ) async {
    try {
      final data = {
        "date": date,
        "reason": reason,
        "lawyerId": lawyerId,
        "location": location,
        "expiredTime": expiredTime,
        "serviceType": serviceType,
        "serviceStatus": "pending",
        "channelName": DateTime.now().millisecondsSinceEpoch,
        "channelToken": "string",
        "price": "$price",
        "lawyerToken": "",
        "userToken": "",
      
      };
    

     final res =  await dio.post('/order/emergency', data: data);
      if(res.statusCode == 201) {
        return right(true);
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }
  EitherBook<Book> setChannel(
    String orderId,
    String channelName,
  ) async {
    final controller = Get.put(HomeController());
    try {
      bool lawyer = controller.currentUserType.value != UserTypes.user;
      bool success = true;
      String tkn = "";

      final token = await getAgoraToken(channelName, lawyer  ? 2 : 1);
       
      token.fold((l) => {
        success = false,
        tkn = l
      }, (r)  => tkn = r );
      if(success) {
        final res = await dio.post(
          '/order/token/$orderId/$channelName/${lawyer.toString()}',
          data: {'token': tkn}); 
      if(res.statusCode == 201) {
        return right(Book.fromJson(res.data));
      }
        return left(res.data);
      } 
      return left(tkn);
    } catch(e) {
      return left(e.toString());
    }

      
  }
EitherBook<Book> getChannel(String id) async {
    try {
      final res = await dio.get(
        '/order/user/$id',
      );
      if(res.statusCode == 200) {
        return right(Book.fromJson(res.data));
      }
      return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

  EitherListBook<List<Book>> orderList() async {
    try {
      final res = await dio.get('/order/user');

      if(res.statusCode == 200) {
        return right(
          (res.data as List).map((e) => Book.fromJson(e)).toList());
      }
       
     return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

  // time

  EitherSuccess<bool> addAvailableDays(Time time) async {
    try {
      final data = {
        "service": time.service,
        "serviceType": time.serviceType,
        "timeDetail": time.timeDetail,
      };
    
      final res = await dio.post('/time', data: data);
     
     if(res.statusCode == 201) {
        return right(true);
      }
      return left(res.data);
    } catch(e) {

      return left(e.toString());
    }
  }

  EitherListTime<List<Time>> activeLawyer(
      String id, String type, int t, bool isActive) async {
    try {
    
      final res = await dio.get('/time/active/$t/$id/$type/$isActive');
      print(res);
      if(res.statusCode == 200) {
        
          return right((res.data as List).map((e) => Time.fromJson(e)).toList());
      }
     return left(res.data);
    } catch(e) {
      return left(e.toString());
    }
  }

  

  
  EitherTime<Time> getTimeLawyer(String id) async {
    try {
      final res = await dio.get(
        '/time/lawyer/$id',
      );
  
     if(res.statusCode == 200) {
      print(res.data);
        return right(Time.fromJson(res.data));
      }
      return left(res.data);
    } catch (e) {
      return left(e.toString());
    }
  }

 


  EitherListTime<List<Time>> getTimeService(String service, String type) async {
    try {
      final res = await dio.get('/time/service/$service/$type');
      if(res.statusCode == 200) {

       return    right((res.data as List).map((e) => Time.fromJson(e)).toList());
      }
      return left(res.data);
    } catch (e) {
      return left(e.toString());
    }
  }
}
