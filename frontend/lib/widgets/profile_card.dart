import 'package:flutter/material.dart';
import 'package:frontend/components/app_scale.dart';
import 'dart:math' as math;

class Profile_Card extends StatelessWidget {
  String? name;
  int? age;
  String? job;
  String? jobAt;
  String image;

  Profile_Card({
    super.key,
    this.age,
    this.job,
    this.name,
    this.jobAt,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    return Container(
      height: _scale.cardHeight,
      width: _scale.cardWidth,
      alignment: const Alignment(0, 0.7),
      child: Container(
        height: _scale.cardHeight - 150,
        width: _scale.cardWidth * 0.85,
        alignment: Alignment.bottomRight,
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Color(0xFF4E4B6F), width: 3)),
        decoration: ShapeDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                image,
                scale: 2,
              )),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            height: _scale.cardHeight / 7,
            width: _scale.cardWidth * 0.8,
            decoration: const ShapeDecoration(
              color: Color(0xA0D9D9D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$name, $age',
                  style: const TextStyle(
                    color: Color(0xFF4E4B6F),
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.48,
                  ),
                ),
                Text(
                  "$job, kohteessa $jobAt",
                  style: TextStyle(
                    color: Color(0xFF0F0C0C),
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.48,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
