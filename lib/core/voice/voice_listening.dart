// lib/screens/voice_listening_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/ia_analyse/ai_analyzing_screen.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/ia_analyse/ai_analyzing_screen.dart';
import 'package:grace_church/feature/home/presentation/bloc/voice_task.dart';


// class VoiceListeningScreen extends StatefulWidget {
//   const VoiceListeningScreen({super.key});
//   @override
//   State<VoiceListeningScreen> createState() => _VoiceListeningScreenState();
// }

// class _VoiceListeningScreenState extends State<VoiceListeningScreen>
//     with TickerProviderStateMixin {
//   late final AnimationController _pulse = AnimationController(
//     vsync: this,
//     duration: const Duration(milliseconds: 1200),
//   )..repeat(reverse: true);
//   late final AnimationController _wave = AnimationController(
//     vsync: this,
//     duration: const Duration(milliseconds: 80),
//   )..repeat(reverse: true);

//   final List<double> _waveHeights = List.generate(9, (_) => 8);
//   int _tick = 0;

//   @override
//   void initState() {
//     super.initState();
//     _wave.addListener(_updateWave);
//   }

//   void _updateWave() {
//     setState(() {
//       _tick++;
//       for (int i = 0; i < _waveHeights.length; i++) {
//         _waveHeights[i] = 8 + (sin((_tick * 0.3 + i) * 0.9).abs() * 22);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pulse.dispose();
//     _wave.removeListener(_updateWave);
//     _wave.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     backgroundColor: Colors.white,
//     body: SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Statutd
//           Text(
//             'Je vous écoute...',
//             style: GoogleFonts.roboto(
//               color: Color(0xFF6B7280),
//               fontSize: 15.sp,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 44.h),

//           // Microphone animé
//           AnimatedBuilder(
//             animation: _pulse,
//             builder: (_, _) => SizedBox(
//               width: 200,
//               height: 200,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   ...List.generate(
//                     3,
//                     (i) => Container(
//                       width: 100 + (i + 1) * 30 + _pulse.value * 10,
//                       height: 100 + (i + 1) * 30 + _pulse.value * 10,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: const Color(
//                           0xFF6366F1,
//                         ).withOpacity(0.1 - i * 0.025),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: const LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(
//                             0xFF6366F1,
//                           ).withOpacity(0.5 + _pulse.value * 0.1),
//                           blurRadius: 36 + _pulse.value * 10,
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.mic_rounded,
//                       color: Colors.white,
//                       size: 37.h,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 40.h),

//           // Ondes audio
//           SizedBox(
//             height: 48.h,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: _waveHeights
//                   .asMap()
//                   .entries
//                   .map(
//                     (e) => AnimatedContainer(
//                       duration: const Duration(milliseconds: 80),
//                       width: 5,
//                       height: e.value,
//                       margin: const EdgeInsets.symmetric(horizontal: 3),
//                       decoration: BoxDecoration(
//                         color: Color.lerp(
//                           const Color(0xFF818CF8),
//                           const Color(0xFF6366F1),
//                           e.value / 30,
//                         ),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//           const SizedBox(height: 40),

//           // Indication enregistrement
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 8,
//                 height: 8,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFEF4444),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//               SizedBox(width: 8.h),
//               Text(
//                 'Enregistrement en cours...',
//                 style: GoogleFonts.roboto(
//                   color: Color(0xFF6B7280),
//                   fontSize: 13.sp,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 48),

//           // Bouton Arrêter
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   //widget.onStop();
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 36,
//                     vertical: 14,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color(0xFF6366F1),
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(32),
//                   ),
//                   child: Text(
//                     'Arrêter',
//                     style: GoogleFonts.roboto(
//                       color: Color(0xFF6366F1),
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AIAnalyzingScreen(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 36,
//                     vertical: 14,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color(0xFF6366F1),
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(32),
//                   ),
//                   child: Text(
//                     'Suivant',
//                     style: GoogleFonts.roboto(
//                       color: Color(0xFF6366F1),
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),

//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             //widget.onCancel,
//             child: Text(
//               'Annuler',
//               style: GoogleFonts.roboto(
//                 color: Color(0xFF6B7280),
//                 fontSize: 14.sp,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }



class VoiceListeningScreen extends StatefulWidget {
  const VoiceListeningScreen({super.key});

  @override
  State<VoiceListeningScreen> createState() =>
      _VoiceListeningScreenState();
}

class _VoiceListeningScreenState extends State<VoiceListeningScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _wave;

  final List<double> _waveHeights = List.generate(9, (_) => 8);
  int _tick = 0;

  @override
  void initState() {
    super.initState();

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _wave = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..repeat(reverse: true);

    _wave.addListener(_updateWave);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VoiceTaskCubit>().start();
    });
  }

  void _updateWave() {
    if (!mounted) return;

    setState(() {
      _tick++;

      for (int i = 0; i < _waveHeights.length; i++) {
        _waveHeights[i] =
            8 + (sin((_tick * 0.3 + i) * 0.9).abs() * 22);
      }
    });
  }

  @override
  void dispose() {
    _pulse.dispose();

    _wave.removeListener(_updateWave);
    _wave.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceTaskCubit, VoiceTaskState>(
      listener: (context, state) {
        if (state is VoiceSuccess) {
       
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AIAnalyzingScreen(
                task: state.result
              ),
            ),
          );
        }

        if (state is VoiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<VoiceTaskCubit, VoiceTaskState>(
        builder: (context, state) {
          final bool isRecording = state is VoiceRecording;
          final bool isLoading = state is VoiceLoading;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoading
                        ? 'Analyse en cours...'
                        : 'Je vous écoute...',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF6B7280),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 44.h),

                  // Microphone animé
                  AnimatedBuilder(
                    animation: _pulse,
                    builder: (_, _) {
                      return SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ...List.generate(
                              3,
                              (i) => Container(
                                width:
                                    100 +
                                    (i + 1) * 30 +
                                    _pulse.value * 10,
                                height:
                                    100 +
                                    (i + 1) * 30 +
                                    _pulse.value * 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFF6366F1,
                                  ).withOpacity(
                                    0.1 - i * 0.025,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF818CF8),
                                    Color(0xFF6366F1),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF6366F1,
                                    ).withOpacity(
                                      0.5 + _pulse.value * 0.1,
                                    ),
                                    blurRadius:
                                        36 + _pulse.value * 10,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.mic_rounded,
                                color: Colors.white,
                                size: 37.h,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 40.h),

                  // Ondes audio
                  SizedBox(
                    height: 48.h,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      children: _waveHeights
                          .asMap()
                          .entries
                          .map(
                            (entry) => AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 80),
                              width: 5,
                              height: isRecording
                                  ? entry.value
                                  : 8,
                              margin:
                                  const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Color.lerp(
                                  const Color(0xFF818CF8),
                                  const Color(0xFF6366F1),
                                  entry.value / 30,
                                ),
                                borderRadius:
                                    BorderRadius.circular(4),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Statut de l'enregistrement
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isRecording
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF6B7280),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        isLoading
                            ? 'Traitement en cours...'
                            : isRecording
                                ? 'Enregistrement en cours...'
                                : 'Enregistrement arrêté',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF6B7280),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Bouton Arrêter
                  if (isRecording)
                    GestureDetector(
                      onTap: () {
                        context
                            .read<VoiceTaskCubit>()
                            .stopAndSend();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF6366F1),
                            width: 2,
                          ),
                          borderRadius:
                              BorderRadius.circular(32),
                        ),
                        child: Text(
                          'Arrêter',
                          style: GoogleFonts.roboto(
                            color:
                                const Color(0xFF6366F1),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                  // Loader pendant l'envoi
                  if (isLoading)
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Color(0xFF6366F1),
                      ),
                    ),

                  const SizedBox(height: 14),

                  // Annuler
                  if (!isLoading)
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Annuler',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF6B7280),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

