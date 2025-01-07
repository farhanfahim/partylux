// To parse this JSON data, do
//
//     final eTickerModel = eTickerModelFromJson(jsonString);


import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FilterModel {
  RxBool? isLocationSelected;
  RxBool? isPeopleSelected;
  double? distance;
  int? minPeople;
  int? maxPeople;

  FilterModel({
    this.isLocationSelected,
    this.isPeopleSelected,
    this.distance,
    this.minPeople,
    this.maxPeople,
  });
}
