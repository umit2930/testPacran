import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/colors.dart';
import '../components/custom_filled_button.dart';


class CodePage extends StatelessWidget {
  CodePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var theme = Theme.of(context);

    TextEditingController pinController = TextEditingController();


    Widget buttonChild;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///Appbar
              Container(
                height: 66.h,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          // Get.off(NumberPage());
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/arrow_right.svg",
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "وارد کردن کد فعالسازی",
                          style: textTheme.bodyMedium?.copyWith(
                              color: natural1, fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 72.h),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: textTheme.bodyLarge?.copyWith(
                                  color:
                                      const Color.fromRGBO(120, 117, 121, 1)),
                              children: [
                                const TextSpan(
                                    text: "لطفا کد فعالسازی که برای "),
                                TextSpan(
                                    text: "",
                                    style: textTheme.bodyLarge),
                                const TextSpan(
                                    text: "\n پیامک شده است را وارد نمایید."),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: TextButton(
                            onPressed: () {

                            },
                            child: const Text("تغییر شماره")),
                      ),

                      ///Pin code
                      Padding(
                        padding: EdgeInsets.only(top: 43.h),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                              controller: pinController,
                              /*  onCompleted: (String value) {
                                loginViewModel.setCode(value);
                              },*/
                              textStyle: theme.textTheme.bodyLarge,
                              keyboardType: TextInputType.number,
                              mainAxisAlignment: MainAxisAlignment.center,
                              enableActiveFill: true,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.circle,
                                fieldHeight: 58.h,
                                fieldWidth: 58.h,
                                borderWidth: 1,
                                activeFillColor: natural8.withOpacity(0.4),
                                selectedFillColor: natural8.withOpacity(0.4),
                                inactiveFillColor: natural8.withOpacity(0.4),
                                activeColor: primary,
                                inactiveColor: natural7,
                                selectedColor: secondary,
                                fieldOuterPadding: EdgeInsets.all(5.h),
                              ),
                              appContext: context,
                              length: 5,
                              onChanged: (value) {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //TODO timer widget
              /*StreamBuilder<NetworkResult<LoginResponse>>(
                  stream: codeViewModel.loginStream.stream,
                  builder: (context, snapshot) {
                    late LoginResponse loginResponse;

                    if (snapshot.hasData) {
                      NetworkResult<LoginResponse>? loginResult =
                          snapshot.data!;
                      //TODO add switch case

                      switch (loginResult.status) {
                        case NetworkStatus.loading:
                          return Container(
                              alignment: Alignment.center,
                              height: 60.h,
                              child: const CircularProgressIndicator());
                          break;
                        case NetworkStatus.error:
                          context.showSnackbar(message:loginResult.message, messageType: MessageType.error,);
                          return SizedBox(
                            height: 60.h,
                            child: TimerWidget(
                              time: 0,
                              number: initResponse.data!.mobile ?? "",
                            ),
                          );

                          break;
                        case NetworkStatus.success:
                          loginResponse = snapshot.data!.data!;

                          break;
                      }
                    } else {
                      loginResponse = initResponse.data!;
                    }

                    return SizedBox(
                      height: 60.h,
                      child: TimerWidget(
                        time: loginResponse.remaining as int,
                        number: loginResponse.mobile ?? "",
                      ),
                    );
                  }),*/
              //TODO button
/*
              Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 16.h, top: 8.h),
                child: StreamBuilder<NetworkResult<VerifyResponse>>(
                  stream: codeViewModel.verifyStream.stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<NetworkResult<VerifyResponse>> snapshot) {
                    // NetworkResult<VerifyResponse>? verifyStatus = viewModel.verifyStatus;

                    if (snapshot.hasData) {
                      var verifyStatus = snapshot.data!;
                      // if (verifyStatus != null) {
                      switch (verifyStatus.status) {
                        case NetworkStatus.loading:
                          buttonChild = const CircularProgressIndicator();
                          break;
                        case NetworkStatus.error:
                          context.showSnackbar(message:verifyStatus.message, messageType: MessageType.error,);
                          buttonChild = const Text("ورود");
                          break;
                        case NetworkStatus.success:
                          AppSharedPreferences appSharedPreferences =
                              Get.find();

                          appSharedPreferences
                              .saveToken(verifyStatus.data?.token ?? "")
                              .then((value) {
                            ApiClient newClient = Get.find();
                            newClient.init();

                            WidgetsBinding.instance.addPostFrameCallback(
                                (_) => Get.offAll(const HomePage()));
                          });
                          buttonChild = const Text("");

                          break;
                      }
                    } else {
                      buttonChild = const Text("ورود");
                    }

                    return SendButton(
                        buttonChild: buttonChild,
                        textEditingController: pinController,
                        onPressed: () {
                          var model = initResponse.data!;
                          codeViewModel.verify(
                              model.mobile!, pinController.text);
                        });
                  },
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  TimerWidget({Key? key, required this.time, required this.number})
      : super(key: key);

  int time;
  String number;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;

  Widget timeWidget = const SizedBox();

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      widget.time--;

      setState(() {});
    });
  }

  @override
  void initState() {
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    if (widget.time > 0) {
      timeWidget = Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            //TODO add dynamic time
            Text(
              " کدی دریافت نشد؟ ${widget.time}ثانیه تا ارسال مجدد ",
              style: textTheme.bodySmall?.copyWith(color: natural5),
            )
          ],
        ),
      );
    } else {
      timeWidget = Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Text(
              "کدی دریافت نشد؟",
              style: textTheme.bodySmall?.copyWith(color: natural5),
            ),
            TextButton(
                onPressed: () {
                  var phone = widget.number;
                },
                child: const Text("ارسال مجدد")),
          ],
        ),
      );
      _timer.cancel();
    }

    return timeWidget;
  }
}

class SendButton extends StatefulWidget {
  SendButton(
      {Key? key,
      required this.buttonChild,
      required this.textEditingController,
      required this.onPressed})
      : super(key: key);

  Widget buttonChild;
  TextEditingController textEditingController;
  Function() onPressed;

  bool listenerSet = false;

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    //TODO write like code page timer setState
    if (widget.listenerSet == false) {
      widget.listenerSet = true;
      widget.textEditingController.addListener(() {
        setState(() {});
      });
    }

    bool isEnable;
    isEnable = (widget.textEditingController.text.length > 4);

    return CustomFilledButton(
      onPressed: isEnable ? widget.onPressed : null,
      buttonChild: widget.buttonChild,
    );
  }
}
