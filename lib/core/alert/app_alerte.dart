import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAlert {
  static void showSuccess(
    BuildContext context,
    String message, {
    IconData? iconRight,
    String? imageIcon,
    Duration duration = const Duration(seconds: 3),
    bool showOnTop = false,

  }) {
    _showAppSnackBar(
      context,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      iconRight: iconRight,
      imageIcon: imageIcon,
      duration: duration,
      showOnTop: showOnTop,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    IconData? iconRight,
    String? imageIcon,
    Duration duration = const Duration(seconds: 3),
    bool showOnTop = false,
    void Function()? onTap,
    bool showEditButton = false,
    IconData? editButtonIcon = Icons.edit,
  }) {
    _showAppSnackBar(
      context,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      iconRight: iconRight,
      imageIcon: imageIcon,
      duration: duration,
      showOnTop: showOnTop,
      onTap: onTap,
      showEditButton: showEditButton,
      editButtonIcon: editButtonIcon,
    );
  }

  static void showInfo(
    BuildContext context,
    String message, {
    IconData? iconRight,
    String? imageIcon,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showAppSnackBar(
      context,
      message: message,
      backgroundColor: Colors.lime,
      icon: Icons.info,
      iconRight: iconRight,
      imageIcon: imageIcon,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    IconData? iconRight,
    String? imageIcon,
    Duration duration = const Duration(seconds: 3),
    bool showOnTop = false,
  }) {
    _showAppSnackBar(
      context,
      message: message,
      backgroundColor: Colors.lime,
      icon: Icons.warning,
      iconRight: iconRight,
      imageIcon: imageIcon,
      duration: duration,
    );
  }

  /// Fonction générique pour afficher une snackbar personnalisée.
  ///
  /// [context] : le BuildContext de la vue actuelle.
  /// [message] : le texte à afficher.
  /// [icon] : une icône optionnelle (ex: Icons.error, Icons.check_circle).
  /// [backgroundColor] : la couleur de fond de la snackbar.
  /// [duration] : durée d’affichage (par défaut 3 secondes).
  ///

  static void _showAppSnackBar(
    BuildContext context, {
    required String message,
    IconData? icon,
    IconData? iconRight,
    Color backgroundColor = Colors.blue,
    String? imageIcon,
    Duration duration = const Duration(seconds: 3),
    bool showOnTop = false,
    bool showEditButton = false,
    void Function()? onTap,
    IconData? editButtonIcon = Icons.edit,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 7.w, vertical: 3.h),
          behavior: showOnTop
              ? SnackBarBehavior.fixed
              : SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          duration: duration,
          content: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white),
                SizedBox(width: 10.w),
              ],
              if (imageIcon != null && imageIcon.isNotEmpty) ...[
                SvgPicture.asset(imageIcon),
                SizedBox(width: 10.w),
              ],
              Expanded(
                child: Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 7.w,
                    vertical: 3.h,
                  ),
                  child: Text(
                    message,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if(showEditButton)...[
                 GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Icon(editButtonIcon, color: Colors.white),
                ),
              ),
              ],
              if (iconRight != null) ...[
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  icon: Icon(iconRight, color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      );
  }

  static void showNotificationPopUp({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.92),

      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
           insetPadding: const EdgeInsets.all(1),
          child: child,
        );
      },
    );
  }
}

class AppBottomSheet {
  Future<dynamic> showBottomSheetScrollable(
    BuildContext context,
    MediaQueryData media,
    Widget Function(double size) contentBuilder, {
    bool isScrollControlled = true,
    double initialChildSize = 0.6,
    double maxChildSize = 0.9,
    double minChildSize = 0.5,
    bool showFromTop = false,
    bool isDismissible = true,
  }) {
    if (showFromTop) {
      return showGeneralDialog(
        context: context,
        barrierDismissible: isDismissible,
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
            position:
                Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
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

class AppGeneretedColors {
  static final Random _random = Random();

  static Color randomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }
}
