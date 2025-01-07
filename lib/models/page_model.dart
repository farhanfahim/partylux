class PageModel<T>{
  final List<T>? data;
  final int total_page,current_page,total_items;
  final bool lastLoaded;
  PageModel({this.data, this.total_page=0,this.current_page=0,this.lastLoaded=false,
    this.total_items=0,});


  factory PageModel.fromJson(List? data,Map? map,T Function(dynamic d) generate){
    List<T> newList=[];
    if(data!=null){
      for(var e in data){
        dynamic obj;
        try {
          obj = generate.call(e);
          newList.add(obj!);
        }
        catch(ex){
          print("page list ex: ${e['_id']} ${ex}");
          //BaseClient.handleError("${e['_id']}: $ex", null);
        }
      }
    }
    return PageModel(data: newList, total_page: map?["totalPages"]??0,total_items: map?["total"]??0);
  }

}