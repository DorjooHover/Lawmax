import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawmax/config/config.dart' as config;

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'package:permission_handler/permission_handler.dart';

/// AudioView Example
class AudioView extends StatefulWidget {
  /// Construct the [AudioView]
  const AudioView(
      {Key? key,
     
      required this.order,
      })
      : super(key: key);

  final Book order;
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AudioView> {
  int? _remoteUid;
  bool lawyer = false;
  Util util = Util();
  late RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = false,
      playEffect = false;
  final controller = Get.put(HomeController());


  Timer? countdownTimer;
  Duration? myDuration ;
 

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void setCountDown() async {
    if (myDuration!.inSeconds == 300) {
      Get.snackbar('Анхааруулга', "5 мин үлдлээ", icon: const Icon(Icons.warning));
    }
    if (myDuration!.inSeconds == 60) {
      Get.snackbar('Анхааруулга', "1 мин үлдлээ", icon: const Icon(Icons.warning));
    }
    if (myDuration!.inSeconds < 1) {
      Get.snackbar('Анхааруулга', "Цаг дууслаа");
      await _leaveChannel();
    }
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration!.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      myDuration = Duration(seconds: widget.order.expiredTime! * 60);
      lawyer = controller.currentUserType.value != UserTypes.user;
    });
    Future.delayed(Duration.zero, () async {
      // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    });

    initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();

    await _engine.release();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, ].request();
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting
    ));
_engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
          startTimer();
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onLeaveChannel: (connection, stats) {
             setState(() {
          isJoined = false;
        });
        stopTimer();
        },
      ),
    );
    

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
   await _engine.joinChannel(
      token: lawyer ? widget.order.lawyerToken! : widget.order.userToken!,
      channelId: widget.order.channelName!,
      uid: lawyer ? 2 : 1,
      options: const ChannelMediaOptions(),
    );
  }

 
  

  _leaveChannel() async {
    await _engine.leaveChannel();
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    setState(() {
      isJoined = false;
      openMicrophone = true;
      enableSpeakerphone = false;
      playEffect = false;
    });
    Get.toNamed(Routes.home);
  }

  _switchMicrophone() async {
    // await await _engine.muteLocalAudioStream(!openMicrophone);
    await _engine.enableLocalAudio(!openMicrophone);
    setState(() {
      openMicrophone = !openMicrophone;
    });
  }

  _switchSpeakerphone() async {
    await _engine.setEnableSpeakerphone(!enableSpeakerphone);
    setState(() {
      enableSpeakerphone = !enableSpeakerphone;
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration!.inMinutes.remainder(60));
    final seconds = strDigits(myDuration!.inSeconds.remainder(60));

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(vertical: huge),
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      width: double.infinity,
      child: _remoteUid != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                space4,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 122,
                        height: 122,
                        decoration: BoxDecoration(
                            color: const Color(0xffc4c4c4),
                            borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          iconUser,
                          width: 57,
                          height: 54,
                        )),
                    space16,
                    Text(
                      !lawyer  ? "Lawmax" : widget.order.clientId!.lastName!,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 69),
                  child: Column(
                    children: [
                      Text(
                        '$minutes:$seconds',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _switchMicrophone,
                            child: Container(
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: !openMicrophone ? primary : lightGray,
                                  borderRadius: BorderRadius.circular(100)),
                              child: SvgPicture.asset(
                                openMicrophone
                                    ? iconMicrophone
                                    : iconMicrophoneDisable,
                                width: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          GestureDetector(
                            onTap: _leaveChannel,
                            child: Container(
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: error,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.call_end,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          GestureDetector(
                            onTap: isJoined ? _switchSpeakerphone : null,
                            child: Container(
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      !enableSpeakerphone ? primary : lightGray,
                                  borderRadius: BorderRadius.circular(100)),
                              child: SvgPicture.asset(
                                enableSpeakerphone
                                    ? iconVolume
                                    : iconVolumeDisable,
                                width: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                '${lawyer  ? 'Хэрэглэгч' : 'Хуульч'} орж иртэл түр хүлээнэ үү ',
                textAlign: TextAlign.center,
              ),
            ),
    ));
  }
}
