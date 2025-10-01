import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFF12122B)),
        CircularParticle(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          awayRadius: 80,
          numberOfParticles: 70,
          speedOfParticles: 1.0,
          onTapAnimation: true,
          particleColor: Colors.lightBlueAccent,
          awayAnimationDuration: Duration(milliseconds: 600),
          maxParticleSize: 4,
          isRandSize: true,
          isRandomColor: false,
          connectDots: true,
        ),
      ],
    );
  }
}


/*
class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFF12122B)),
        CircularParticle(
          key: UniqueKey(),
          awayRadius: 80,
          numberOfParticles: 70,
          speedOfParticles: 1.0,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          onTapAnimation: true,
          //backgroundColor: Color(0x0012122B),
          particleColor: Colors.lightBlueAccent, //.withOpacity(0.7),
          awayAnimationDuration: const Duration(milliseconds: 600),
          maxParticleSize: 4,
          isRandSize: true,
          isRandomColor: false,
          connectDots: true, // draw lines between particles
        ),
      ],
    );
  }
}
*/
