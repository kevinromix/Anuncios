import 'package:flutter/material.dart';

class ChangeImage extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  const ChangeImage({
    super.key,
    required this.image1,
    required this.image2,
    required this.image3,
  });

  @override
  State<ChangeImage> createState() => _ChangeImageState();
}

class _ChangeImageState extends State<ChangeImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late String _image;

  @override
  void initState() {
    _image = widget.image1;

    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Change image action method
  IconButton customIconButton(String image) {
    return IconButton(
      onPressed: () {
        setState(() {
          _image = image;
        });
      },
      icon: Icon(
        _image == image ? Icons.circle : Icons.circle_outlined,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/$_image.jpg',
          fit: BoxFit.cover,
          width: 270,
          height: 160,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customIconButton(widget.image2),
            customIconButton(widget.image1),
            customIconButton(widget.image3),
          ],
        ),
      ],
    );
  }
}
