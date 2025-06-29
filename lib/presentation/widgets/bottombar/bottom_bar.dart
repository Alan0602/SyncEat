import 'package:flutter/material.dart';
import 'package:synceat/core/constants/color_constants.dart';

class BottomNavItem {
  final IconData icon;
  // final String label;

  BottomNavItem({
    required this.icon,
    // required this.label
  });
}

class AnimatedBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const AnimatedBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  State<AnimatedBottomNavigationBar> createState() =>
      _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState
    extends State<AnimatedBottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _translateAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 80,
      margin: EdgeInsets.only(
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
        bottom: bottomPadding > 0 ? 8 : 16,
      ),
      decoration: BoxDecoration(
        color: ColorConstants.navBackground,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.items.length,
          (index) => _buildNavItem(index),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = widget.currentIndex == index;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth =
        (screenWidth - 34) / widget.items.length; // Responsive width

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: itemWidth,
            padding: EdgeInsets.symmetric(
              horizontal: itemWidth * 0.1,
              vertical: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset:
                      isSelected
                          ? Offset(0, _translateAnimation.value)
                          : Offset.zero,
                  child: Transform.scale(
                    scale: isSelected ? _scaleAnimation.value : 1.0,
                    child: Container(
                      width: itemWidth * 0.6,
                      height: itemWidth * 0.6,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                        maxWidth: 50,
                        maxHeight: 50,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            isSelected
                                ? LinearGradient(
                                  colors: [
                                    ColorConstants.primaryColor,
                                    ColorConstants.secondaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                : null,
                        color: isSelected ? null : Colors.transparent,
                      ),
                      child: Icon(
                        widget.items[index].icon,
                        color:
                            isSelected
                                ? ColorConstants.whiteColor
                                : ColorConstants.inactiveColor,
                        size:
                            itemWidth * 0.25 < 20
                                ? 20
                                : (itemWidth * 0.25 > 24
                                    ? 24
                                    : itemWidth * 0.25),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isSelected ? 4 : 2),
                // AnimatedDefaultTextStyle(
                //   duration: const Duration(milliseconds: 200),
                //   style: TextStyle(
                //     color:
                //         isSelected
                //             ? ColorConstants.primaryColor
                //             : ColorConstants.inactiveColor,
                //     fontSize:
                //         isSelected
                //             ? (screenWidth < 360 ? 10 : 12)
                //             : (screenWidth < 360 ? 8 : 10),
                //     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                //   ),
                //   child: Text(
                //     widget.items[index].label,
                //     textAlign: TextAlign.center,
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
