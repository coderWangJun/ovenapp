import 'package:flutter/material.dart';

class SliverSpaceDelegate extends SliverPersistentHeaderDelegate {
  SliverSpaceDelegate(this._c);

  static double dSpaceHeight = 55.0;

  final Container _c;

  @override
  double get minExtent => dSpaceHeight;

  @override
  double get maxExtent => dSpaceHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _c;
  }

  @override
  bool shouldRebuild(SliverSpaceDelegate oldDelegate) {
    return false;
  }
}

class SliverWidgetDelegate extends SliverPersistentHeaderDelegate {
  SliverWidgetDelegate(this._c, this.cheight);

  final double cheight;
  final Container _c;
  // static double dTitleHeight=45.0;

  @override
  double get minExtent => cheight;

  @override
  double get maxExtent => cheight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _c;
  }

  @override
  bool shouldRebuild(SliverWidgetDelegate oldDelegate) {
    return false;
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
