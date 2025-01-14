import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../utils/constant/constant.dart';
import '../../../../../../utils/helper/time_format.dart';
import '../../../../../../utils/helper/weather_format.dart';

class CTimeWeather extends StatelessWidget {
  const CTimeWeather({
    super.key,
    required this.weather,
    required this.temperature,
  });

  final String weather;
  final double temperature;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GColors.backgroundField,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              GFormat.formatTime(DateTime.now()),
              style:
                  Poppins.bold.copyWith(fontSize: 18, color: GColors.darkGrey),
            ),
          ),
        ),
        Gap(10),
        Expanded(
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GColors.backgroundField,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(weatherFormatAnimation(weather)),
                Gap(10),
                Text(
                  '${(temperature - 273.15).toStringAsFixed(1)}°C',
                  style: Poppins.bold
                      .copyWith(fontSize: 18, color: GColors.darkGrey),
                ),
              ],
            ),
            // Text(
            //   weather,
            //     style:
            //         Poppins.bold.copyWith(fontSize: 18, color: GColors.darkGrey),
            //   ),
          ),
        )
      ],
    );
  }
}
