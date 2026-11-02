
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class SharaMicButton extends StatefulWidget {
  final bool isListening;
  final bool isLoading;
  final VoidCallback onPressed;

  const SharaMicButton({
    super.key,
    required this.isListening,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<SharaMicButton> createState() => _SharaMicButtonState();
}

class _SharaMicButtonState extends State<SharaMicButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool get _active => widget.isListening || widget.isLoading;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (_active) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant SharaMicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_active && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!_active && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final buttonSize = 64.w;

    return Container(
      padding: EdgeInsets.all(2.r),

      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ondes pulsées
          // if (widget.isListening) ...[
          //   _ripple(0.0),
          //   _ripple(0.33),
          //   _ripple(0.66),
          // ],

          // Anneau de chargement
          if (widget.isLoading)
            SizedBox(
              width: buttonSize + 2.w,
              height: buttonSize + 2.w,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),

          // Bouton (légère pulsation)
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: AppColors.primary),
              iconSize: 32.sp,
              onPressed: widget.isLoading ? null : widget.onPressed,
              icon: Icon(
                widget.isListening ? Icons.stop : Icons.mic,
                key: ValueKey(widget.isListening),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
