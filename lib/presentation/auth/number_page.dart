import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/custom_filled_button.dart';
import 'number_filed.dart';

class NumberPage extends StatelessWidget {
  const NumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 28.h),
                        width: 112.w,
                        height: 170.h,
                        child: Image.asset("assets/images/login.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 56.h),
                        child: Text("لطفا شماره همراه خود را وارد نمایید.",
                            style: textTheme.titleSmall),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "شماره موبایل",
                            style: textTheme.bodySmall,
                          ),
                        ),
                      ),
                      NumberField(
                        textController: textController,
                      )
                    ],
                  ),
                ),
              ),
              //TODO send button
              /*  Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 16.h, top: 8.h),
                child: StreamBuilder<NetworkResult<LoginResponse>>(
                  stream: loginViewModel.loginStream.stream,
                  builder: (context, snapShot) {
                    Widget buttonChild;

                    if (snapShot.hasData) {
                      NetworkResult<LoginResponse>? loginResponse =
                          snapShot.data!;
                      // loginViewModel.loginStatus;

                      // if (loginStatus != null) {
                      switch (loginResponse.status) {
                        case NetworkStatus.loading:
                          buttonChild = const CircularProgressIndicator();
                          break;
                        case NetworkStatus.error:
                          context.showSnackbar(message:loginResponse.message, messageType: MessageType.error,);
                          */ /*var snackBar = SnackBar(
                            content: Text(
                                loginResponse.message ?? "مشکلی روی داده است."),
                          );

                          WidgetsBinding.instance.addPostFrameCallback((_) =>
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar));*/ /*
                          buttonChild = const Text("ارسال کد");
                          break;
                        case NetworkStatus.success:
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => Get.off(
                              CodePage(
                                initResponse: loginResponse,
                              ),
                            ),
                          );

                          buttonChild = const CircularProgressIndicator();
                          break;
                      }
                      // } else {
                      //   text = "ارسال کد";
                      // }

                      */ /* return SendButton(text, () {
                        print("send called");
                        loginViewModel.login();
                      });*/ /*
                    } else {
                      buttonChild = const Text("ارسال کد");
                      */ /* return SendButton("ارسال کد", () {
                        print("send called");
                        loginViewModel.login();
                      });*/ /*
                    }

                    return SendButton(
                        buttonChild: buttonChild,
                        textEditingController: textController,
                        onPressed: () {
                          loginViewModel.login("0${textController.text}");
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
        var controller = widget.textEditingController;
        if (controller.text == "0") {
          controller.text = "";
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }
        setState(() {});
      });
    }

    bool isEnable;
    isEnable = (widget.textEditingController.text.length > 9);

    return CustomFilledButton(
      onPressed: isEnable ? widget.onPressed : null,
      // text: "ارسال کد",
      buttonChild: widget.buttonChild,
    );
  }
}
