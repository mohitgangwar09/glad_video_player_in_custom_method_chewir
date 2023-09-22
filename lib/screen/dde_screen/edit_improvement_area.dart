import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/improvement_area_cubit/improvement_area_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EditImprovementArea extends StatefulWidget {
  const EditImprovementArea({super.key, required this.improvementIndex, required this.farmerId});
  final int improvementIndex;
  final int farmerId;

  @override
  State<EditImprovementArea> createState() => _EditImprovementAreaState();
}

class _EditImprovementAreaState extends State<EditImprovementArea> {
  WebViewController? controller;
  @override
  void initState() {
    BlocProvider.of<ImprovementAreaCubit>(context).generateController(widget.improvementIndex);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://jubilantanimalnutrition.com/paymentGatewayForm/id='WT-1266'/msg='XT38ouMc+AVVH1IOOyd4+yB7PhAJJhrKDyH0qAHmlKLiyWu6rkSilQ2qua6Y4bjsD5IEdcSFK2kp2BINYj80rL31yz9xPPTr/eGmKJoArV7UW1V9vPUAzsdmN6HZpYKQed2QKkfK0Bqn/HYfDgilrJZYe+JmK9Ndoz4b7QUXtkBRlsNuur/MvEe5DOA3cXg6GHyJcdpbnD5v2CoOcgifLGoDWCThiITEGXggU8EixncXC4emBfsOFDk67R8J+nEkPZDq7gfS9uejtspqwAxoa+zSnHV0br9my72PRclzCxG3DBv61lhwkA3T1AvQN9jxPqbnVFeHGd0iB0ubBdFWcIDXNFu0b/SS8LGhrWlFZfDxIflDvbPRMyDv0Y8YWYiNA1HOdp5bD4x/yMJqYmnHEp8V1Xh/7gohfo2BKCFFwodsmrFFlL317MliLhF6r0P9zYW8NcUg3zuRqxVCUwmkbKuIkUO+y68y/BShBs7T/nxks/Ebfu5BjR0g/NqW5l7Tdc0QgrpVG369UNz+Bd6GXzy1i8q8G42+Oz2Z+Ke2Q/XmrSNQE9uCZoRrXwFtlGW9Z+OcmMgHG/LxpU9SqtAwrN69Xl+u9bhvB9u5QpRK0r/FgYVHeOPL45Gq0CaAd494dtpu+V9s/hBI6JWFxtijIzXWwAuxVNPpl+ODLuLfQf7Xo+PAqKlzo3Ya8Jy9xUmsSVgIc7Vru99IY9Wix5MWSy636xUQy8/gyU6oh1iszIrBAS72x/JhVqOZ66Sa+PdzzEuTPXpZMclJ2iluQU14Cw=='"));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller!)
    );
  }
}
