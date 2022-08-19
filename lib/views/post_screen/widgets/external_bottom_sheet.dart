import 'package:flutter/material.dart';
import 'package:go_blog/utils/launch_url.dart';

class ExternalBottomSheet extends StatefulWidget {
  String url;
  ExternalBottomSheet({Key? key, required this.url}) : super(key: key);

  @override
  State<ExternalBottomSheet> createState() => _ExternalBottomSheetState();
}

class _ExternalBottomSheetState extends State<ExternalBottomSheet> {
  @override
  void initState() {
    super.initState();
    widget.url = widget.url.contains("http")
        ? widget.url
        : "https://go.dev${widget.url}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 200,
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        const Text(
          "Open external link?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(widget.url),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            openURL(widget.url);
          },
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size.fromHeight(50))),
          child: const Text("Open link on browser"),
        ),
      ]),
    );
  }
}
