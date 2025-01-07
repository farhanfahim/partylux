class DropDownItem{

  final String? id,text;
  DropDownItem({required this.id,required this.text,});

  String getId() => id??"";
  String getText() => text??"";

  @override
  bool operator == (Object other) {
    return other is DropDownItem && other.getId()==getId();
  }

}

class ValueType<T> extends DropDownItem{

  //static const UNIT_DOLLAR_PER_HOUR="\$/Hr",UNIT_YEARS="years",UNIT_HRS="Hrs";

  final T? value;
  final String? unit;
  ValueType({
    required super.text,this.unit,
    this.value,
  }):super(id: text,);


/*  @override
  String toString() {
    return getText();
  }*/

}