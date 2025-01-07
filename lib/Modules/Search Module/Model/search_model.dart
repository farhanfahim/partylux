class SearchModel{
  final String? id;
  final String? query;
  const SearchModel({this.query,this.id,});

  factory SearchModel.fromJson(Map json){
    return SearchModel(id: json["_id"],query: json["query"]);
  }

}