library grouped_list;

import 'dart:collection';

import 'package:flutter/widgets.dart';

class GroupedListView<T, E> extends StatefulWidget {
  final E Function(T element) groupBy;
  final Widget Function(E value) groupSeparatorBuilder;
  final Widget Function(BuildContext context, T element) itemBuilder;
  final Widget Function(BuildContext context, T element, int index)
      indexedItemBuilder;
  final GroupedListOrder order;
  final bool useStickyGroupSeparators;
  final Widget separator;
  final List<T> elements;
  final Key key;
  final ScrollController controller;
  final Axis scrollDirection;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;
  final bool hasFooter;
  final Widget renderFooter;

  GroupedListView({
    @required this.elements,
    @required this.groupBy,
    @required this.groupSeparatorBuilder,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.order = GroupedListOrder.ASC,
    this.useStickyGroupSeparators = false,
    this.separator = const SizedBox.shrink(),
    this.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.hasFooter = false,
    this.renderFooter,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GroupedLisdtViewState<T, E>();
}

class _GroupedLisdtViewState<T, E> extends State<GroupedListView<T, E>> {
  ScrollController _controller;
  Map<String, GlobalKey> _keys = LinkedHashMap<String, GlobalKey>();
  GlobalKey _groupHeaderKey;
  List<T> _sortedElements = [];
  GlobalKey _key = GlobalKey();
  int _topElementIndex = 0;

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this._sortedElements = widget.elements;
    final itemCount = (widget.hasFooter ? 1 : 0) + _sortedElements.length * 2;
    return Column(
      key: _key,
      children: <Widget>[
        _showFixedGroupHeader(),
        ListView.builder(
          scrollDirection: widget.scrollDirection,
          controller: _getController(),
          primary: widget.primary,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          padding: widget.padding,
          itemCount: itemCount,
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          cacheExtent: widget.cacheExtent,
          itemBuilder: (context, index) {
            int actualIndex = index ~/ 2;
            if (index == 0) {
              if (widget.useStickyGroupSeparators) {
                return const SizedBox.shrink();
              }
              return widget.groupSeparatorBuilder(
                  widget.groupBy(_sortedElements[actualIndex]));
            }

            if(actualIndex == _sortedElements.length && widget.hasFooter &&
            widget.renderFooter != null){
              return widget.renderFooter;
            }

            if (index.isEven) {
              E curr = widget.groupBy(_sortedElements[actualIndex]);
              E prev = widget.groupBy(_sortedElements[actualIndex - 1]);
              if (prev != curr) {
                return widget.groupSeparatorBuilder(
                    widget.groupBy(_sortedElements[actualIndex]));
              }
              return widget.separator;
            }
            return _buildItem(context, actualIndex);
          },
        ),
      ],
    );
  }

  Container _buildItem(context, int actualIndex) {
    GlobalKey key = GlobalKey();
    _keys['$actualIndex'] = key;
    return Container(
        key: key,
        child: widget.indexedItemBuilder == null
            ? widget.itemBuilder(context, _sortedElements[actualIndex])
            : widget.indexedItemBuilder(
                context, _sortedElements[actualIndex], actualIndex));
  }

  ScrollController _getController() {
    _controller =
        widget.controller == null ? ScrollController() : widget.controller;
    if (widget.useStickyGroupSeparators) {
      _controller.addListener(_scrollListener);
    }
    return _controller;
  }

  _scrollListener() {
    RenderBox listBox = _key.currentContext.findRenderObject();
    double listPos = listBox.localToGlobal(Offset.zero).dy;
    RenderBox headerBox = _groupHeaderKey.currentContext.findRenderObject();
    double headerHeight = headerBox.size.height;
    double max = double.negativeInfinity;
    String topItemKey = '0';
    for (var entry in _keys.entries) {
      var key = entry.value;
      if (_isListItemRendered(key)) {
        RenderBox itemBox = key.currentContext.findRenderObject();
        double y =
            itemBox.localToGlobal(Offset(0, -listPos - 2 * headerHeight)).dy;
        if (y <= 0 && y > max) {
          topItemKey = entry.key;
          max = y;
        }
      }
    }
    setState(() {
      _topElementIndex = int.parse(topItemKey);
    });
  }

  Widget _showFixedGroupHeader() {
    _groupHeaderKey = GlobalKey();
    if (widget.useStickyGroupSeparators && widget.elements.length > 0) {
      return Container(
        key: _groupHeaderKey,
        child: widget.groupSeparatorBuilder(
            widget.groupBy(_sortedElements[_topElementIndex])),
      );
    }
    return Container();
  }

  bool _isListItemRendered(GlobalKey<State<StatefulWidget>> key) {
    return key.currentContext != null &&
        key.currentContext.findRenderObject() != null;
  }
}

enum GroupedListOrder { ASC, DESC }
