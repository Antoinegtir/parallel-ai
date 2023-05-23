import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoader {
  static CustomLoader? _customLoader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader!;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader!;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState? _overlayState; //= new OverlayState();
  OverlayEntry? _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: buildLoader(context));
      },
    );
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState!.insert(_overlayEntry!);
  }

  hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print("Exception:: $e");
    }
  }

  buildLoader(BuildContext context, {Color? backgroundColor}) {
    backgroundColor ??= const Color(0xffa8a8a8).withOpacity(.5);
    var height = 150.0;
    return CustomScreenLoader(
      height: height,
      width: height,
      backgroundColor: backgroundColor,
    );
  }
}

class CustomScreenLoader extends StatefulWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  const CustomScreenLoader(
      {Key? key,
      this.backgroundColor = Colors.transparent,
      this.height = 30,
      this.width = 30})
      : super(key: key);

  @override
  State<CustomScreenLoader> createState() => _CustomScreenLoaderState();
}

class _CustomScreenLoaderState extends State<CustomScreenLoader> {
  @override
  Widget build(BuildContext context) {
    final darkmode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : Colors.black;
    return Container(
      color: widget.backgroundColor,
      child: Container(
          height: widget.height,
          width: widget.height,
          color: darkmode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                  "https://assets1.lottiefiles.com/packages/lf20_drhp9zqp.json"),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(height: 110, child: AdWidget(ad: _nativeAd!)),
              //   ],
              // )
            ],
          )),
    );
  }
}
