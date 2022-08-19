import 'dart:math';

List<String> _viewImageList = [
  "assets/img/view1.jpg",
  "assets/img/view2.jpg",
  "assets/img/view3.jpg",
  "assets/img/view4.jpg",
  "assets/img/view5.jpg",
  "assets/img/view6.jpg",
  "assets/img/view7.jpg",
];

String getRandomViewImage() {
  final _random = Random();

  return _viewImageList[_random.nextInt(_viewImageList.length)];
}
