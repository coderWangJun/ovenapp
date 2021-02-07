import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class IntroSwiperPage extends StatelessWidget {
  final List<Image> _lstImage = [];

  @override
  Widget build(BuildContext context) {
    _lstImage.add(Image.asset('images/photo_eraser.png'));
    _lstImage.add(Image.asset('images/photo_pencil.png'));
    _lstImage.add(Image.asset('images/photo_ruler.png'));

    return Container(
      child: _getAdvertSwiper(),
    );
  }

  _getAdvertSwiper() {
    return Swiper(
      // itemBuilder: _swiperBuilder,
      // itemWidth: 300.0,
      itemBuilder: _getSwiperImage,
      itemCount: _lstImage.length,
      pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
        color: Colors.black54,
        activeColor: Colors.white,
      )),
      control: null, // new SwiperControl(),
      scrollDirection: Axis.horizontal,
      // layout: SwiperLayout.STACK,
      // autoplay: true,
      onTap: (index) => print('点击了第$index个'),
    );
  }

  Widget _getSwiperImage(BuildContext context, int index) {
    return _lstImage[index];
  }
}
