import 'package:confs_tech/widgets/ellipsis_painter.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget  {
  final List<Widget> actions;
  final Function(String) onSearchTextChanged;

  const SearchBar({Key key, this.actions, this.onSearchTextChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState(actions: actions, onSearchTextChanged: onSearchTextChanged);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin {
  final TextEditingController _filter = new TextEditingController();
  final List<Widget> actions;

  Widget _appBarTitle = new Text('Confs.tech');
  Function(String) onSearchTextChanged;
  bool isInSearchMode = false;
  double rippleStartX, rippleStartY;
  AnimationController _controller;
  Animation _animation;

  _SearchBarState({ this.actions, this.onSearchTextChanged });

  @override
  Widget build(BuildContext context) {
    return _buildBar(context);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(animationStatusListener);
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });

    _controller.forward();
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        _toggleAppBarStatus();
      });
    }
  }

  Widget _buildBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (isInSearchMode){
          _toggleAppBarStatus();
          return false;
        } else {
          return true;
        }
      },
      child: Stack(
          children: [
            AppBar(
              backgroundColor: isInSearchMode ?
              Colors.white : Theme.of(context).primaryColor,
              title: _appBarTitle,
              leading: isInSearchMode ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _toggleAppBarStatus,
              ) : null,
              actions: List.unmodifiable(() sync* {
                if (!isInSearchMode) yield
                GestureDetector(
                  child: Icon(Icons.search),
                  onTapUp: onSearchTapUp,
                );
                if (!isInSearchMode && this.actions != null) {
                  yield* this.actions;
                }
              }()),
            ),
            !isInSearchMode ? AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                    painter: EllipsisPainter(
                        containerHeight: widget.preferredSize.height,
                        offset: Offset(rippleStartX ?? 0, rippleStartY ?? 0),
                        radius: _animation.value * screenWidth,
                        context: context
                    )
                );
              },
            ) : Container()
          ]
      ),
    );
  }

  void _toggleAppBarStatus() {
    setState(() {
      if (!isInSearchMode) {
        isInSearchMode = true;
        this._appBarTitle = new TextField(
          onChanged: (text){
            if(onSearchTextChanged != null)
              onSearchTextChanged(_filter.text);
          },
          autofocus: true,
          controller: _filter,
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: 'Event name or location...',
            hintStyle: TextStyle(color: Colors.black)
          ),
        );
      } else {
        isInSearchMode = false;
        this._appBarTitle = new Text('Confs.tech');
        if(onSearchTextChanged != null && _filter.text != '')
          onSearchTextChanged('');
        _filter.clear();
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    onSearchTextChanged = null;
    _filter.dispose();
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

}