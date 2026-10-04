import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Route fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 400), // durée de la fade
  );
}






Future<dynamic> showBottomSheetScrollable(
  BuildContext context,
  MediaQueryData media,
  Widget Function(double size) contentBuilder, {
  bool isScrollControlled = true,
  double initialChildSize = 0.6,
  double maxChildSize = 0.9,
  double minChildSize = 0.5,
  bool showFromTop = false,
}) {
  if (showFromTop) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: contentBuilder(initialChildSize),
        ),
      ),
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),
    ),
    isScrollControlled: true,
    builder: (_) {
      return _DraggableBottomSheetContent(
        contentBuilder: contentBuilder,
        initialChildSize: initialChildSize,
        maxChildSize: maxChildSize,
        minChildSize: minChildSize,
      );
    },
  );
}

class _DraggableBottomSheetContent extends StatefulWidget {
  const _DraggableBottomSheetContent({
    required this.contentBuilder,
    this.initialChildSize = 0.6,
    this.maxChildSize = 0.9,
    this.minChildSize = 0.5,
  });
  final Widget Function(double size) contentBuilder;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;

  @override
  State<_DraggableBottomSheetContent> createState() =>
      _DraggableBottomSheetContentState();
}

class _DraggableBottomSheetContentState
    extends State<_DraggableBottomSheetContent> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  late double _currentSize;
  double _previousKeyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    _currentSize = widget.initialChildSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(_updateSize);
    });
  }

  void _updateSize() {
    if (mounted) {
      setState(() {
        _currentSize = _controller.size;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleKeyboardVisibility();
  }

  void _handleKeyboardVisibility() {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    if (keyboardHeight > 0 && _previousKeyboardHeight == 0) {
      // Clavier ouvert - agrandir le bottom sheet
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.isAttached && mounted) {
          _controller.animateTo(
            widget.maxChildSize,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    } else if (keyboardHeight == 0 && _previousKeyboardHeight > 0) {
      // Clavier fermé - revenir à la taille initiale
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.isAttached && mounted) {
          _controller.animateTo(
            widget.initialChildSize,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    }
    _previousKeyboardHeight = keyboardHeight;
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSize);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return DraggableScrollableSheet(
      controller: _controller,
      expand: false,
      initialChildSize: widget.initialChildSize,
      minChildSize: widget.minChildSize,
      maxChildSize: widget.maxChildSize,
      builder: (_, scrollController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  height: 4.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: const Color(0XFF8D8D8D),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7.h),
                    widget.contentBuilder(_currentSize - 0.1),
                    SizedBox(height: keyboardHeight + 24),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}




   Future<dynamic> showBottomSheetNotation({
    Widget? headerWidget,
    required BuildContext context,
    required MediaQueryData media,
    required Widget content,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          maxChildSize: 0.9,
          // initialChildSize: .4,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              margin: EdgeInsets.only(
                bottom: media.viewInsets.bottom,
              ),
              child: SizedBox(
                height: 1.sh,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        if (headerWidget != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              headerWidget,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.r,
                                  vertical: 7.h,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.grey
                                            .withValues(alpha: .5),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon:  Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (headerWidget != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Divider(
                              color: Colors.grey.withValues(alpha: .5),
                              height: .3,
                            ),
                          ),
                        content,
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
