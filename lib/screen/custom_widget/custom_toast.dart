import 'package:flutter/material.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CustomToast extends StatelessWidget {
  final String message;

  const CustomToast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.topRight,
          width: MediaQuery.of(context).size.width,
          child: PhysicalModel(
            color: Colors.white,
            elevation: 8,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          Images.errorIcon,
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: DefaultTextStyle(
                          style: figtreeRegular.copyWith(
                              color: Colors.black, fontSize: 14),
                          child: Text(
                            message.toString(),
                            style: figtreeRegular.copyWith(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
