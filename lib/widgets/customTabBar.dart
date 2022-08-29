// // Copyright 2014 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// import 'dart:ui' show lerpDouble;
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/gestures.dart' show DragStartBehavior;
//
// enum CustomTabBarIndicatorSize {
//   CustomTab,
//   label,
// }
//
// const double _kCustomTabHeight = 46.0;
// const double _kCustomTextAndIconTabHeight = 72.0;
//
// class CustomTab extends StatelessWidget {
//
//
//
//   const CustomTab({
//     Key key,
//     this.text,
//     this.icon,
//     this.child,
//     this.tabHeight = _kCustomTabHeight,
//     this.textToIconMargin = 0.0, this.iconMargin,
//   }) : assert(text != null || child != null || icon != null),
//         assert(!(text != null && null != child)),
//         assert(textToIconMargin >= 0.0),
//         super(key: key);
//
//   final double tabHeight;
//   final double textToIconMargin;
//   final String text;
//   final Widget child;
//   final Widget icon;
//   final EdgeInsetsGeometry iconMargin;
//
//   Widget _buildLabelText() {
//     return child ?? Text(text, softWrap: false, overflow: TextOverflow.fade);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterial(context));
//
//     double height;
//     Widget label;
//
//     if (icon == null) {
//       height = _kCustomTabHeight;
//       label = _buildLabelText();
//     } else if (text == null && child == null) {
//       height = _kCustomTabHeight;
//       label = icon;
//     } else {
//       height = _kCustomTextAndIconTabHeight;
//       label = Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             child: icon,
//             margin: EdgeInsets.only(bottom: textToIconMargin),
//           ),
//           _buildLabelText(),
//         ],
//       );
//     }
//
//     if (tabHeight > _kCustomTabHeight) {
//       height = tabHeight;
//     }
//
//     return SizedBox(
//       height: height,
//       child: Center(
//         child: label,
//         widthFactor: 1.0,
//       ),
//     );
//   }
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(StringProperty('text', text, defaultValue: null));
//     properties.add(DiagnosticsProperty<Widget>('icon', icon, defaultValue: null));
//   }
// }
//
// class TabBar extends StatefulWidget implements PreferredSizeWidget {
//   const TabBar({
//     Key key,
//     @required this.tabs,
//     this.controller,
//     this.isScrollable = false,
//     this.indicatorColor,
//     this.automaticIndicatorColorAdjustment = true,
//     this.indicatorWeight = 2.0,
//     this.indicatorPadding = EdgeInsets.zero,
//     this.indicator,
//     this.indicatorSize,
//     this.labelColor,
//     this.labelStyle,
//     this.labelPadding,
//     this.unselectedLabelColor,
//     this.unselectedLabelStyle,
//     this.dragStartBehavior = DragStartBehavior.start,
//     this.overlayColor,
//     this.mouseCursor,
//     this.enableFeedback,
//     this.onTap,
//     this.physics,
//   }) : assert(tabs != null),
//         assert(isScrollable != null),
//         assert(dragStartBehavior != null),
//         assert(indicator != null || (indicatorWeight != null && indicatorWeight > 0.0)),
//         assert(indicator != null || (indicatorPadding != null)),
//         super(key: key);
//
//   final List<Widget> tabs;
//   final TabController controller;
//   final bool isScrollable;
//   final Color indicatorColor;
//   final double indicatorWeight;
//   final EdgeInsetsGeometry indicatorPadding;
//   final Decoration indicator;
//   final bool automaticIndicatorColorAdjustment;
//   final TabBarIndicatorSize indicatorSize;
//   final Color labelColor;
//   final Color unselectedLabelColor;
//   final TextStyle labelStyle;
//   final EdgeInsetsGeometry labelPadding;
//   final TextStyle unselectedLabelStyle;
//   final MaterialStateProperty<Color> overlayColor;
//   final DragStartBehavior dragStartBehavior;
//   final MouseCursor mouseCursor;
//   final bool enableFeedback;
//   final ValueChanged<int> onTap;
//   final ScrollPhysics physics;
//   @override
//   Size get preferredSize {
//     for (final Widget item in tabs) {
//       if (item is Tab) {
//         final Tab tab = item;
//         if ((tab.text != null || tab.child != null) && tab.icon != null)
//           return Size.fromHeight(_kCustomTextAndIconTabHeight + indicatorWeight);
//       }
//     }
//     return Size.fromHeight(_kCustomTabHeight + indicatorWeight);
//   }
//
//   @override
//   _CustomTabBarState createState() => _CustomTabBarState();
// }
//
// class CustomTabHelper {
//   const CustomTabHelper({
//     this.text,
//     this.icon,
//     this.child,
//   }) : assert(text != null || child != null || icon != null),
//         assert(!(text != null && null != child));
//
//   final String text;
//   final Widget child;
//   final Widget icon;
// }
//
// class _TabBarState extends State<TabBar> {
//   ScrollController? _scrollController;
//   TabController? _controller;
//   _IndicatorPainter? _indicatorPainter;
//   int? _currentIndex;
//   late double _tabStripWidth;
//   late List<GlobalKey> _tabKeys;
//
//   @override
//   void initState() {
//     super.initState();
//     // If indicatorSize is TabIndicatorSize.label, _tabKeys[i] is used to find
//     // the width of tab widget i. See _IndicatorPainter.indicatorRect().
//     _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();
//   }
//
//   Decoration get _indicator {
//     if (widget.indicator != null)
//       return widget.indicator!;
//     final TabBarTheme tabBarTheme = TabBarTheme.of(context);
//     if (tabBarTheme.indicator != null)
//       return tabBarTheme.indicator!;
//
//     Color color = widget.indicatorColor ?? Theme.of(context).indicatorColor;
//     // ThemeData tries to avoid this by having indicatorColor avoid being the
//     // primaryColor. However, it's possible that the tab bar is on a
//     // Material that isn't the primaryColor. In that case, if the indicator
//     // color ends up matching the material's color, then this overrides it.
//     // When that happens, automatic transitions of the theme will likely look
//     // ugly as the indicator color suddenly snaps to white at one end, but it's
//     // not clear how to avoid that any further.
//     //
//     // The material's color might be null (if it's a transparency). In that case
//     // there's no good way for us to find out what the color is so we don't.
//     //
//     // TODO(xu-baolin): Remove automatic adjustment to white color indicator
//     // with a better long-term solution.
//     // https://github.com/flutter/flutter/pull/68171#pullrequestreview-517753917
//     if (widget.automaticIndicatorColorAdjustment && color.value == Material.of(context)?.color?.value)
//       color = Colors.white;
//
//     return UnderlineTabIndicator(
//       borderSide: BorderSide(
//         width: widget.indicatorWeight,
//         color: color,
//       ),
//     );
//   }
//
//   // If the TabBar is rebuilt with a new tab controller, the caller should
//   // dispose the old one. In that case the old controller's animation will be
//   // null and should not be accessed.
//   bool get _controllerIsValid => _controller?.animation != null;
//
//   void _updateTabController() {
//     final TabController? newController = widget.controller ?? DefaultTabController.of(context);
//     assert(() {
//       if (newController == null) {
//         throw FlutterError(
//             'No TabController for ${widget.runtimeType}.\n'
//                 'When creating a ${widget.runtimeType}, you must either provide an explicit '
//                 'TabController using the "controller" property, or you must ensure that there '
//                 'is a DefaultTabController above the ${widget.runtimeType}.\n'
//                 'In this case, there was neither an explicit controller nor a default controller.'
//         );
//       }
//       return true;
//     }());
//
//     if (newController == _controller)
//       return;
//
//     if (_controllerIsValid) {
//       _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
//       _controller!.removeListener(_handleTabControllerTick);
//     }
//     _controller = newController;
//     if (_controller != null) {
//       _controller!.animation!.addListener(_handleTabControllerAnimationTick);
//       _controller!.addListener(_handleTabControllerTick);
//       _currentIndex = _controller!.index;
//     }
//   }
//
//   void _initIndicatorPainter() {
//     _indicatorPainter = !_controllerIsValid ? null : _IndicatorPainter(
//       controller: _controller!,
//       indicator: _indicator,
//       indicatorSize: widget.indicatorSize ?? TabBarTheme.of(context).indicatorSize,
//       indicatorPadding: widget.indicatorPadding,
//       tabKeys: _tabKeys,
//       old: _indicatorPainter,
//     );
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     assert(debugCheckHasMaterial(context));
//     _updateTabController();
//     _initIndicatorPainter();
//   }
//
//   @override
//   void didUpdateWidget(TabBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.controller != oldWidget.controller) {
//       _updateTabController();
//       _initIndicatorPainter();
//     } else if (widget.indicatorColor != oldWidget.indicatorColor ||
//         widget.indicatorWeight != oldWidget.indicatorWeight ||
//         widget.indicatorSize != oldWidget.indicatorSize ||
//         widget.indicator != oldWidget.indicator) {
//       _initIndicatorPainter();
//     }
//
//     if (widget.tabs.length > oldWidget.tabs.length) {
//       final int delta = widget.tabs.length - oldWidget.tabs.length;
//       _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
//     } else if (widget.tabs.length < oldWidget.tabs.length) {
//       _tabKeys.removeRange(widget.tabs.length, oldWidget.tabs.length);
//     }
//   }
//
//   @override
//   void dispose() {
//     _indicatorPainter!.dispose();
//     if (_controllerIsValid) {
//       _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
//       _controller!.removeListener(_handleTabControllerTick);
//     }
//     _controller = null;
//     // We don't own the _controller Animation, so it's not disposed here.
//     super.dispose();
//   }
//
//   int get maxTabIndex => _indicatorPainter!.maxTabIndex;
//
//   double _tabScrollOffset(int index, double viewportWidth, double minExtent, double maxExtent) {
//     if (!widget.isScrollable)
//       return 0.0;
//     double tabCenter = _indicatorPainter!.centerOf(index);
//     switch (Directionality.of(context)) {
//       case TextDirection.rtl:
//         tabCenter = _tabStripWidth - tabCenter;
//         break;
//       case TextDirection.ltr:
//         break;
//     }
//     return (tabCenter - viewportWidth / 2.0).clamp(minExtent, maxExtent);
//   }
//
//   double _tabCenteredScrollOffset(int index) {
//     final ScrollPosition position = _scrollController!.position;
//     return _tabScrollOffset(index, position.viewportDimension, position.minScrollExtent, position.maxScrollExtent);
//   }
//
//   double _initialScrollOffset(double viewportWidth, double minExtent, double maxExtent) {
//     return _tabScrollOffset(_currentIndex!, viewportWidth, minExtent, maxExtent);
//   }
//
//   void _scrollToCurrentIndex() {
//     final double offset = _tabCenteredScrollOffset(_currentIndex!);
//     _scrollController!.animateTo(offset, duration: kTabScrollDuration, curve: Curves.ease);
//   }
//
//   void _scrollToControllerValue() {
//     final double? leadingPosition = _currentIndex! > 0 ? _tabCenteredScrollOffset(_currentIndex! - 1) : null;
//     final double middlePosition = _tabCenteredScrollOffset(_currentIndex!);
//     final double? trailingPosition = _currentIndex! < maxTabIndex ? _tabCenteredScrollOffset(_currentIndex! + 1) : null;
//
//     final double index = _controller!.index.toDouble();
//     final double value = _controller!.animation!.value;
//     final double offset;
//     if (value == index - 1.0)
//       offset = leadingPosition ?? middlePosition;
//     else if (value == index + 1.0)
//       offset = trailingPosition ?? middlePosition;
//     else if (value == index)
//       offset = middlePosition;
//     else if (value < index)
//       offset = leadingPosition == null ? middlePosition : lerpDouble(middlePosition, leadingPosition, index - value)!;
//     else
//       offset = trailingPosition == null ? middlePosition : lerpDouble(middlePosition, trailingPosition, value - index)!;
//
//     _scrollController!.jumpTo(offset);
//   }
//
//   void _handleTabControllerAnimationTick() {
//     assert(mounted);
//     if (!_controller!.indexIsChanging && widget.isScrollable) {
//       // Sync the TabBar's scroll position with the TabBarView's PageView.
//       _currentIndex = _controller!.index;
//       _scrollToControllerValue();
//     }
//   }
//
//   void _handleTabControllerTick() {
//     if (_controller!.index != _currentIndex) {
//       _currentIndex = _controller!.index;
//       if (widget.isScrollable)
//         _scrollToCurrentIndex();
//     }
//     setState(() {
//       // Rebuild the tabs after a (potentially animated) index change
//       // has completed.
//     });
//   }
//
//   // Called each time layout completes.
//   void _saveTabOffsets(List<double> tabOffsets, TextDirection textDirection, double width) {
//     _tabStripWidth = width;
//     _indicatorPainter?.saveTabOffsets(tabOffsets, textDirection);
//   }
//
//   void _handleTap(int index) {
//     assert(index >= 0 && index < widget.tabs.length);
//     _controller!.animateTo(index);
//     if (widget.onTap != null) {
//       widget.onTap!(index);
//     }
//   }
//
//   Widget _buildStyledTab(Widget child, bool selected, Animation<double> animation) {
//     return _TabStyle(
//       animation: animation,
//       selected: selected,
//       labelColor: widget.labelColor,
//       unselectedLabelColor: widget.unselectedLabelColor,
//       labelStyle: widget.labelStyle,
//       unselectedLabelStyle: widget.unselectedLabelStyle,
//       child: child,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterialLocalizations(context));
//     assert(() {
//       if (_controller!.length != widget.tabs.length) {
//         throw FlutterError(
//             "Controller's length property (${_controller!.length}) does not match the "
//                 "number of tabs (${widget.tabs.length}) present in TabBar's tabs property."
//         );
//       }
//       return true;
//     }());
//     final MaterialLocalizations localizations = MaterialLocalizations.of(context);
//     if (_controller!.length == 0) {
//       return Container(
//         height: _kTabHeight + widget.indicatorWeight,
//       );
//     }
//
//     final TabBarTheme tabBarTheme = TabBarTheme.of(context);
//
//     final List<Widget> wrappedTabs = <Widget>[
//       for (int i = 0; i < widget.tabs.length; i += 1)
//         Center(
//           heightFactor: 1.0,
//           child: Padding(
//             padding: widget.labelPadding ?? tabBarTheme.labelPadding ?? kTabLabelPadding,
//             child: KeyedSubtree(
//               key: _tabKeys[i],
//               child: widget.tabs[i],
//             ),
//           ),
//         )
//     ];
//
//     // If the controller was provided by DefaultTabController and we're part
//     // of a Hero (typically the AppBar), then we will not be able to find the
//     // controller during a Hero transition. See https://github.com/flutter/flutter/issues/213.
//     if (_controller != null) {
//       final int previousIndex = _controller!.previousIndex;
//
//       if (_controller!.indexIsChanging) {
//         // The user tapped on a tab, the tab controller's animation is running.
//         assert(_currentIndex != previousIndex);
//         final Animation<double> animation = _ChangeAnimation(_controller!);
//         wrappedTabs[_currentIndex!] = _buildStyledTab(wrappedTabs[_currentIndex!], true, animation);
//         wrappedTabs[previousIndex] = _buildStyledTab(wrappedTabs[previousIndex], false, animation);
//       } else {
//         // The user is dragging the TabBarView's PageView left or right.
//         final int tabIndex = _currentIndex!;
//         final Animation<double> centerAnimation = _DragAnimation(_controller!, tabIndex);
//         wrappedTabs[tabIndex] = _buildStyledTab(wrappedTabs[tabIndex], true, centerAnimation);
//         if (_currentIndex! > 0) {
//           final int tabIndex = _currentIndex! - 1;
//           final Animation<double> previousAnimation = ReverseAnimation(_DragAnimation(_controller!, tabIndex));
//           wrappedTabs[tabIndex] = _buildStyledTab(wrappedTabs[tabIndex], false, previousAnimation);
//         }
//         if (_currentIndex! < widget.tabs.length - 1) {
//           final int tabIndex = _currentIndex! + 1;
//           final Animation<double> nextAnimation = ReverseAnimation(_DragAnimation(_controller!, tabIndex));
//           wrappedTabs[tabIndex] = _buildStyledTab(wrappedTabs[tabIndex], false, nextAnimation);
//         }
//       }
//     }
//
//     // Add the tap handler to each tab. If the tab bar is not scrollable,
//     // then give all of the tabs equal flexibility so that they each occupy
//     // the same share of the tab bar's overall width.
//     final int tabCount = widget.tabs.length;
//     for (int index = 0; index < tabCount; index += 1) {
//       wrappedTabs[index] = InkWell(
//         mouseCursor: widget.mouseCursor ?? SystemMouseCursors.click,
//         onTap: () { _handleTap(index); },
//         enableFeedback: widget.enableFeedback ?? true,
//         overlayColor: widget.overlayColor,
//         child: Padding(
//           padding: EdgeInsets.only(bottom: widget.indicatorWeight),
//           child: Stack(
//             children: <Widget>[
//               wrappedTabs[index],
//               Semantics(
//                 selected: index == _currentIndex,
//                 label: localizations.tabLabel(tabIndex: index + 1, tabCount: tabCount),
//               ),
//             ],
//           ),
//         ),
//       );
//       if (!widget.isScrollable)
//         wrappedTabs[index] = Expanded(child: wrappedTabs[index]);
//     }
//
//     Widget tabBar = CustomPaint(
//       painter: _indicatorPainter,
//       child: _CustomTabStyle(
//         animation: kAlwaysDismissedAnimation,
//         selected: false,
//         labelColor: widget.labelColor,
//         unselectedLabelColor: widget.unselectedLabelColor,
//         labelStyle: widget.labelStyle,
//         unselectedLabelStyle: widget.unselectedLabelStyle,
//         child: _TabLabelBar(
//           onPerformLayout: _saveTabOffsets,
//           children: wrappedTabs,
//         ),
//       ),
//     );
//
//     if (widget.isScrollable) {
//       _scrollController ??= _CustomTabBarScrollController(this);
//       tabBar = SingleChildScrollView(
//         dragStartBehavior: widget.dragStartBehavior,
//         scrollDirection: Axis.horizontal,
//         controller: _scrollController,
//         physics: widget.physics,
//         child: tabBar,
//       );
//     }
//
//     return tabBar;
//   }
// }
