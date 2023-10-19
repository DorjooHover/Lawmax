import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawmax/config/config.dart' as config;

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoView extends StatefulWidget {
  const VideoView(
      {Key? key,

      required this.order,
})
      : super(key: key);

  final Book order;
  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
int? _remoteUid;
  late RtcEngine _engine;
  bool isJoined = false;
  final homeController = Get.put(HomeController());
  bool isSwitchCamera = false;
  bool isMuted = false;
  bool isSpeaker = false;
  bool isCamera = true, lawyer = false;
  Util util = Util();
  double rating = 0;

  final controller = Get.put(HomeController());
  Timer? countdownTimer;
  late Book order;
  Duration? myDuration;

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    if (countdownTimer != null) {
      setState(() => countdownTimer!.cancel());
    }
  }

  void setCountDown() async {
    if (myDuration!.inSeconds == 300) {
      Get.snackbar('Анхааруулга', "5 мин үлдлээ", icon: const Icon(Icons.warning));
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialogView(
      //           icon: Icons.expand_outlined,
      //           title: 'Таны уулзалт дуусахад 5 мин үлдлээ.',
      //           text: 'Та уулзалтаа сунгах уу?',
      //           approve: () {
      //             myDuration = Duration(minutes: 6);
      //             Navigator.pop(context);
      //           },
      //           color: warning);
      //     });
    }
    if (myDuration!.inSeconds == 60) {
      Get.snackbar('Анхааруулга', "1 мин үлдлээ", icon: const Icon(Icons.warning));
    }

    const reduceSecondsBy = 1;

    if (mounted) {
      setState(() {
        final seconds = myDuration!.inSeconds - reduceSecondsBy;
        if (seconds < 0 && countdownTimer != null) {
          Get.snackbar('Анхааруулга', "Цаг дууслаа");
          _onCallEnd();
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  
    setState(() {
      order = widget.order;
      myDuration = Duration(seconds: widget.order.expiredTime! * 60);
      lawyer = homeController.currentUserType.value != UserTypes.user;
    });
    Future.delayed(Duration.zero, () async {
      // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE)
      //     .then((value) => print(value));
    });

    initAgora();
  }

  @override
  void dispose() async {
    _onCallEnd();

    super.dispose();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = createAgoraRtcEngine();
    await _engine.initialize( RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
     _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            isJoined = true;
          });
          //           if (_remoteUid == null) {
          //   controller.callOrder(order);
          // }

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

       await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();
   await _engine.joinChannel(
      token: lawyer ? order.lawyerToken! : order.userToken!,
      channelId: order.channelName!,
      uid: lawyer ? 2 : 1,
      options: const ChannelMediaOptions(),
    );
    print("asdf: ${lawyer ? order.lawyerToken! : order.userToken!}");
    print("asdf: ${order.channelName!}");
    print("asdf: ${lawyer ? 2 : 1}");
  }

  Future<void> _onCallEnd() async {
    try {
      await _engine.leaveChannel();
      if (!lawyer) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialogView(
                  icon: Icons.expand_outlined,
                  title: 'Та хуульчид санал өгнө үү.',
                  text: '',
                  approveBtn: 'Илгээх',
                  cancelBtn: 'Болих',
                  approve: () {
                    Navigator.of(context).pop();
                    controller.sendRate(
                        order.lawyerId!.sId!, rating == 0 ? 1 : rating);
                  },
                  cancel: () {
                    Navigator.of(context).pop();
                  },
                  color: success,
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (r) {
                      setState(() {
                        rating = r;
                      });
                    },
                  ));
            }).then((value) => Get.toNamed(Routes.home));
      }
    } catch (error) {
      Get.snackbar(error.toString(), 'error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration!.inMinutes.remainder(60));
    final seconds = strDigits(myDuration!.inSeconds.remainder(60));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _remoteVideo(minutes, seconds),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 150,
                child: Center(
                  child: isJoined
                      ? AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: _engine,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _remoteVideo(String minutes, String seconds) {
    if (_remoteUid != null) {
      return Stack(
        children: [
          AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine,
              canvas: VideoCanvas(uid: _remoteUid),
              connection: RtcConnection(channelId: order.channelName!),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 150,
              left: 0,
              right: 0,
              child: Align(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: medium, vertical: small),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(origin),
                      color: Colors.white,
                    ),
                    child: Text(
                      '$minutes:$seconds',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 70),
                  onPressed: () {
                    setState(() {
                      isMuted = !isMuted;
                      _engine.muteAllRemoteAudioStreams(isMuted);
                    });
                  },
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: isMuted ? primary : Colors.white,
                  padding: const EdgeInsets.all(origin),
                  child: SvgPicture.asset(
                    !isMuted ? iconMicrophone : iconMicrophoneDisable,
                    width: 14,
                  ),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 70),
                  onPressed: () {
                    _onCallEnd();
                    setState(() {
                      if (countdownTimer != null) {
                        countdownTimer!.cancel();
                      }
                    });
                  },
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: error,
                  padding: const EdgeInsets.all(origin),
                  child:
                      const Icon(Icons.call_end, color: Colors.white, size: 35),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 60),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: isSwitchCamera ? primary : Colors.white,
                  padding: const EdgeInsets.all(origin),
                  onPressed: () {
                    setState(() {
                      isSwitchCamera = !isSwitchCamera;
                    });
                    _engine.switchCamera();
                  },
                  child: Icon(
                    Icons.switch_camera,
                    color: !isSwitchCamera ? primary : Colors.white,
                    size: 20.0,
                  ),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 70),
                  onPressed: () => {
                    setState(() {
                      isCamera = !isCamera;

                      if (!isCamera) {
                        _engine.disableVideo();
                      } else {
                        _engine.enableVideo();
                      }
                    })
                  },
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  fillColor: !isCamera ? primary : Colors.white,
                  padding: const EdgeInsets.all(origin),
                  child: Icon(
                    !isCamera ? Icons.videocam_off : Icons.videocam,
                    color: !isCamera ? Colors.white : primary,
                    size: 20.0,
                  ),
                )
              ],
            ),
          )
        ],
      );
    } else {
      // return ListView(
      //   children: [
      //     Text(widget.token),
      //     SizedBox(height: 300),
      //     Text(widget.channelName),
      //     Text(
      //       widget.uid.toString(),
      //     ),
      //     ...logs.map((e) => Text(e))
      //   ],
      // );
      return Center(
        child: Text(
          '${lawyer ? 'Хэрэглэгч' : 'Хуульч'} орж иртэл түр хүлээнэ үү ',
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
