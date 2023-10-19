import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lawmax/controllers/auth_controller.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/provider/providers.dart';
import 'package:lawmax/routes.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:lawmax/config/config.dart' as config;
import 'dart:developer' as dev;
class HomeController extends GetxController
    with StateMixin<User>, WidgetsBindingObserver {
  final ApiRepository apiRepository = ApiRepository();

  final showPerformanceOverlay = false.obs;
  Util util = Util();
    final authController = Get.put(AuthController());
  final currentIndex = 0.obs;
  final isLoading = false.obs;
  final rxUser = Rxn<User?>();
  
  final our = false.obs;
  final loading = false.obs;
  final emergencyOrder = Rxn<Book?>();
  final storage = GetStorage();
  late IO.Socket socket;
  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;
  final currentUserType = UserTypes.user.obs;

  Future<void> setupApp() async {
    isLoading.value = true;
    try {
  
      final res = await apiRepository.getUser();
      res.fold((l) => {
       
        Get.toNamed(Routes.auth),
        util.logout()
      }, (r) => {
        
       user = r,
        change(user, status: RxStatus.success()),
    
        currentUserType.value = user?.userType ?? UserTypes.user,
      
         socket = IO.io(
            'https://lawyernestjs-production.up.railway.app', <String, dynamic>{
          'autoConnect': false,
          'transports': ['websocket'],
        }),
        socket.connect(),
        socket.onConnect(
          (data) => {
            
            if (user?.userType == UserTypes.our) {our.value = true},
          },
        ),

        socket.onDisconnect((_) => {
         
              if (user?.userType == UserTypes.our) {our.value = false}
            }),
        socket.onConnectError((data) => {
          
              if (user?.userType == UserTypes.our) {our.value = false}
            }),
        socket.onError((error) => {
       
              if (user?.userType == UserTypes.our) {our.value = false}
            }),
        socket.on(('response_emergency_order'), ((data) {
          Book order = Book.fromJson(
              jsonDecode(jsonEncode(data)) as Map<String, dynamic>);

          if (our.value || order.lawyerId?.sId == user?.sId) {
            emergencyOrder.value = order;
            callkit(order);
            print(order.toJson());
          }

          if (order.clientId?.sId == user?.sId) {
            getChannelToken(order, false, '');
          }
        })),
        socket.on(
            ('onlineEmergency'),
            ((data) => {
                  if ((data as List).contains(socket.id) == true)
                    {dev.log(socket.id!)}
                })),

      });
     
      
    } catch (e) {

      util.logout();
      update();
    }
  }

  callOrder(Book order, ) {
    if (order.date != null &&
        order.date! > DateTime.now().millisecondsSinceEpoch - 30 * 60000 &&
        order.date! < DateTime.now().millisecondsSinceEpoch + 30 * 60000) {
      // if (order.lawyerId?.sId == user?.sId && userType == user?.userType) {
      //   callkit(order);
      // }
      // if (order.clientId?.sId == user?.sId && userType == user?.userType) {
      //   callkit(order);
      // }
    }
  }
  logout() async {
await storage.remove(StorageKeys.token.name);
setupApp().then((value) => currentIndex.value = 0);
    
    
  }

  sendRate(String id, double rate) async {
    await apiRepository.sendRating(id, rate, '');
  }

  getChannelToken(Book order, bool isLawyer, String? profileImg) async {
    try {
      loading.value = true;

      final res = await apiRepository.getChannel(order.sId!);
      res.fold((l) => null, (r) async => {
        if(r.lawyerToken == 'string' || r.userToken == 'string') {
           await apiRepository.setChannel(
          order.sId!,
          r.channelName!
        ).then((value) {
          value.fold((l) => null, (right) {
             if(r.serviceType == 'onlineEmergency') {
          Get.to(() => AudioView(order: right));
        }
        if(r.serviceType == 'online') {
          Get.to(() => VideoView(order: right, ));
        }
          });
        }),
       
        } else {
           if(r.serviceType == 'onlineEmergency') {
       Get.to(() => AudioView(order: r))
        },
        if(r.serviceType == 'online') {
          Get.to(() => VideoView(order: r, ))
        }
        }
      });


      loading.value = false;
    }  catch (e) {
      loading.value = false;
     
    }
  }

  callkit(Book order) async {
    CallKitParams params = CallKitParams(
      id: order.sId,
      nameCaller: order.clientId?.firstName,
      appName: "Lawmax",
      avatar: "https://i.pravata.cc/100",
      handle: order.clientId?.lastName,
      type: 0,
      textAccept: "Дуудлага авах",
      textDecline: "Дуудлага цуцлах",
      duration: 30000,
      extra: {'userId': order.clientId?.sId},
      ios: const IOSParams(
          iconName: "Lawmax",
          handleType: 'generic',
          supportsVideo: true,
          maximumCallGroups: 2,
          maximumCallsPerCallGroup: 1,
          audioSessionMode: 'default',
          audioSessionActive: true,
          audioSessionPreferredSampleRate: 44100.0,
          audioSessionPreferredIOBufferDuration: 0.005,
          supportsDTMF: true,
          supportsHolding: true,
          supportsGrouping: false,
          ringtonePath: 'system_ringtone_default'),
      android: const AndroidParams(
          isCustomNotification: true,
          isShowLogo: false,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: "#0955fa",
          backgroundUrl: "https://i.pravata.cc/500",
          actionColor: "#4CAF50",
          incomingCallNotificationChannelName: "Дуудлага ирж байна",
          missedCallNotificationChannelName: "Аваагүй дуудлага"),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
      print(event);
      switch (event!.event) {
        case Event.actionCallIncoming:
          
          break;
        case Event.actionCallStart:
          // started an outgoing call
          //  show screen calling in Flutter
          break;
        case Event.actionCallAccept:
          await getChannelToken(
              order, user?.userType != UserTypes.user, user?.profileImg ?? '');

          break;
        case Event.actionCallDecline:
          //  declined an incoming call
          break;
        case Event.actionCallEnded:
          //  ended an incoming/outgoing call
          break;
        case Event.actionCallTimeout:
          //  missed an incoming call
          break;

        case Event.actionDidUpdateDevicePushTokenVoip:
          //  Handle this case.
          break;
        case Event.actionCallCallback:
          //  Handle this case.
          break;
        case Event.actionCallToggleHold:
          //  Handle this case.
          break;
        case Event.actionCallToggleMute:
          //  Handle this case.
          break;
        case Event.actionCallToggleDmtf:
          //  Handle this case.
          break;
        case Event.actionCallToggleGroup:
          //  Handle this case.
          break;
        case Event.actionCallToggleAudioSession:
          //  Handle this case.
          break;
        case Event.actionCallCustom:
          //  Handle this case.
          break;
      }
    });
  }

  Future<bool> createEmergencyOrder(
    String lawyerId,
    int expiredTime,
    int price,
    String serviceType,
    String reason,
    LocationDto location,
  ) async {
    Map data = {
      "userId": user!.sId,
      "date": DateTime.now().millisecondsSinceEpoch,
      "reason": reason,
      "lawyerId": lawyerId,
      "location": location,
      "expiredTime": expiredTime,
      "serviceType": serviceType,
      "serviceStatus": "pending",
      "channelName": DateTime.now().millisecondsSinceEpoch,
      "channelToken": "string",
      "price": price,
      "lawyerToken": "string",
      "userToken": "string",
    };
    socket.emit('create_emergency_order', data);
    return true;
  }

  // changeOrderStatus(String id, String status) {
  //   Map data = {"id": id, "status": status};
  //   socket.emit('change_order_status', data);
  // }

  @override
  void onInit() async {
    await setupApp();
    super.onInit();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

}
