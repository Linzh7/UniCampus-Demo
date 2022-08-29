// import 'package:flustars/flustars.dart';
//
// final Map<String, double> longitudeMap = {
//   "1": 114.3339713,
//   "新一": 114.3339713,
//   "新二": 114.3353807,
//   "新三": 114.332368,
//   "新四": 114.3341285,
//   "鉴主": 114.3439540,
//   "鉴一": 114.3430904475,
//   // "鉴二": 114.34865,
//   "鉴三": 114.3446538,
//   "鉴四": 114.3459769,
//   "鉴湖生活区": 114.3441237,
//   "西院行政楼": 114.3485005,
//   "东一": 114.36176,
// };
//
// final Map<String, double> latitudeMap = {
//   "1": 30.51184028,
//   "新一": 30.51184028,
//   "新二": 30.51159494,
//   "新三": 30.51211171,
//   "新四": 30.51246165,
//   "鉴主": 30.512833025,
//   "鉴一": 30.5127066,
//   // "鉴二": 30.519391,
//   "鉴三": 30.5124131,
//   "鉴四": 30.5147500,
//   "鉴湖生活区": 30.5144496,
//   "西院行政楼": 30.5225981,
//   "东一": 30.525473,
// };
//
// final Map<String, double> longitudeRangeMap = {
//   "1": 30.51184028,
//   "新一": 0.000893725,
//   "新二": 0.00055665,
//   "新三": 0.0008146,
//   "新四": 0.000450687,
//   "鉴主": 0.0004828,
//   "鉴一": 0.0006016,
//   // "鉴二": 0.00035,
//   "鉴三": 0.0004113,
//   "鉴四": 0.0002466,
//   "鉴湖生活区": 0.0010017,
//   "西院行政楼": 0.0004705,
//   "东一": 0.0006,
// };
//
// final Map<String, double> latitudeRangeMap = {
//   "1": 30.51184028,
//   "新一": 0.00040999,
//   "新二": 0.000416735,
//   "新三": 0.000356815,
//   "新四": 0.00017261,
//   "鉴主": 0.0002269,
//   "鉴一": 0.0002363,
//   // "鉴二": 0.00015,
//   "鉴三": 0.0003298,
//   "鉴四": 0.0003799,
//   "鉴湖生活区": 0.0012805,
//   "西院行政楼": 0.0003464,
//   "东一": 0.00018,
// };
//
// class SignUtil {
//   static bool isInPlace(double longitude, double latitude, String location) {
//     double long = longitudeMap[location]!,
//         lati = latitudeMap[location]!,
//         longRange = longitudeRangeMap[location]!,
//         latiRange = latitudeRangeMap[location]!;
//     if (long - longRange < longitude &&
//         longitude < long + longRange &&
//         lati - latiRange < latitude &&
//         latitude < lati + latiRange) {
//       LogUtil.v(
//           "[Location] True. Now at $longitude, $latitude, while wanna be $long, $lati in $longRange and $latiRange.");
//       return true;
//     } else {
//       LogUtil.v(
//           "[Location] False. Now at $longitude, $latitude, while wanna be $long, $lati in $longRange and $latiRange.");
//       return false;
//     }
//   }
//
//   static String placeText(double longitude, double latitude, String location) {
//     double long = longitudeMap[location]!,
//         lati = latitudeMap[location]!,
//         longRange = longitudeRangeMap[location]!,
//         latiRange = latitudeRangeMap[location]!;
//     if (long - longRange < longitude &&
//         longitude < long + longRange &&
//         lati - latiRange < latitude &&
//         latitude < lati + latiRange) {
//       return "[Location] True. Now at $location, $longitude, $latitude, \nlongitude in ${long - longRange} - ${long + longRange}, \nlatitude in ${lati - latiRange} - ${lati + latiRange}.";
//     } else {
//       return "[Location] False. Now at $location, $longitude, $latitude, \nlongitude in ${long - longRange} - ${long + longRange}, \nlatitude in ${lati - latiRange} - ${lati + latiRange}.";
//     }
//   }
// }
