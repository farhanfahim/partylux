class Media{

  static const TYPE_AUDIO="audio",TYPE_IMAGE="image",TYPE_VIDEO="video",TYPE_DOC="document";

  // static const EXT_PDF="pdf";

  final String? type,extension;//image,audio,video...
  String? _name;
  String? id;
  String? _value;
  final List<int> bytes;
  final String? thumbNail;
  final ImageType imageType;
  final int? size;
  Media({this.id, this.type,String? name, String? value,this.bytes=const [],this.thumbNail,
    this.imageType=ImageType.TYPE_FILE,this.size,this.extension,}){
    _value=value;
    _name=name;
  }


  String get value => _value??"";

  set value(String value) {
    _value = value;
  }

  String get name => (_name??"");

  factory Media.fromJson(Map map,{ImageType imageType= ImageType.TYPE_NETWORK,String? id,}){
    return Media(type: map["type"],value: map["url"],size: map["size"],name: map["name"],
      imageType: imageType,id:id,);
  }

  Map<String,dynamic> toJson(){
    return {"name":name,"type":type!,"url":value,"size":size!,};
  }

}

enum ImageType{
  TYPE_ASSET,TYPE_FILE,TYPE_NETWORK
}
