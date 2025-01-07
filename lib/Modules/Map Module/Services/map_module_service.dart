import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';

import '../../../Utils/Network/api_client.dart';
import '../../../Utils/Network/api_urls.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../Utils/Network/tost.dart';
import '../../../models/page_model.dart';
import '../../BecomePartner/Model/become_partner_model.dart';
import '../../Home Module/Model/event_model.dart';
import '../../add_location_picker/model/local_location.dart';

abstract class MapModuleService {

  Future<PageModel<EventModel>?> paginatedEvents({
    required int length,
    int? page,
    required String categoryType,
  }) async {
    PageModel<EventModel>? events;
    LocalLocation localLocation = await DatabaseHandler().getLocation();
    double radius = await DatabaseHandler().getRadius();

    final Map<String, dynamic> map = {
      "page": page,
      'limit': length,
      "isPaginated": 1,
      "eventCategory": categoryType,
      "latitude": localLocation.coordinates![0],
      "longitude": localLocation.coordinates![1],
      "distance": radius.round()*1.60934,
    };
    print("get event body: ${map}");


    try {

      var response = await API().get(
        ApiManager.GET_EVENTS ,
        queryParameters: map,
      );
      print("response -->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        var data=response.data["data"];
        events=PageModel.fromJson(data["data"], data, (d) {
          return EventModel.fromJson(d);
        });
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return events;
  }

  Future<List<EventModel>> events({
    required String categoryType,
  }) async {
    List<EventModel> createEventModel = [];
    LocalLocation localLocation = await DatabaseHandler().getLocation();
    double radius = await DatabaseHandler().getRadius();

    final Map<String, dynamic> map = {

      "eventCategory": categoryType,
      "latitude": localLocation.coordinates![0],
      "longitude": localLocation.coordinates![1],
      "distance": radius.round()*1.60934,
    };
    print("get event body: ${map}");
    try {
      var response = await API().get(
        ApiManager.GET_EVENTS ,
        queryParameters: map,
      );

      if (response == null) {
      } else if (response.statusCode == 200) {

        createEventModel = EventModel.fromJsonToList(response.data["data"]);


      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return createEventModel;
  }
}
