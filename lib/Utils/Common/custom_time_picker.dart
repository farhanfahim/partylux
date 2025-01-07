import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/date_time_util.dart';


class TimePicker extends StatefulWidget {


  final double height;
  final double? width;
  final DateTime? initialTime;
  final void Function(String time) onSelectTime;
  const TimePicker({Key? key,this.height=150,this.width,this.initialTime,
    required this.onSelectTime,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TimePickerState();
  }

}

class _TimePickerState extends State<TimePicker>{

  static const TOD_LIST=[DateTimeUtil.TOD_AM,DateTimeUtil.TOD_PM];

  late String hour,min,tod;

  late FixedExtentScrollController hourScroll,minScroll,todScroll;

  @override
  void initState() {
    initializeTime();
    hourScroll=FixedExtentScrollController(initialItem: int.parse(hour)-1);
    minScroll=FixedExtentScrollController(initialItem: int.parse(min));
    todScroll=FixedExtentScrollController(initialItem: TOD_LIST.indexOf(tod));
    widget.onSelectTime(getTime());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //widget.onSelectTime(getTime());
    super.didChangeDependencies();
  }

  String getTime(){
    return "$hour:$min $tod";
  }

  @override
  void dispose() {
    hourScroll.dispose();
    minScroll.dispose();
    todScroll.dispose();
    super.dispose();
  }

  void initializeTime(){
    final DateTime date=widget.initialTime??DateTime.now();
    final String time=formatTime12(date.hour, date.minute);
    final List<String> list1=time.split(" ");
    final List<String> list2=list1[0].split(":");
    hour=list2[0];
    min=list2[1];
    tod=list1[1];
  }

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    return Container(//height: widget.height,width: widget.width,
      width: media.width*0.5,
      //width: 200,
      //width: 50,
      child: Row(children: [
        buildItem(count: 12,
            value: hour,increment: true,
            controller: hourScroll,
            onSelected: (val){
              setState(() {
                hour=val;
              });
              widget.onSelectTime(getTime());
            }),
        buildItem(count: 60,
            value: min,
            controller: minScroll,
            onSelected: (val){
              setState(() {
                min=val;
              });
              widget.onSelectTime(getTime());
            }),
        buildItem(list: TOD_LIST,
            value: tod,
            controller: todScroll,
            onSelected: (val){
              setState(() {
                tod=val;
              });
              widget.onSelectTime(getTime());
            })
      ],),
    );
  }

  Widget buildItem({
    FixedExtentScrollController? controller,
    List<String>? list,int? count,String? value,
    bool increment=false,
    required Function(String val) onSelected}){
    assert(list!=null || count!=null);
    return Expanded(
      child: CupertinoPicker.builder(
        scrollController: controller,
        itemExtent: 60,
        selectionOverlay:Container(),
        onSelectedItemChanged: (ind){
          final String value=list?[ind]??getNum(increment?(ind+1):ind);
          onSelected(value);
        },
        //selectionOverlay: Container(),
        itemBuilder: (con,ind){
          final String val=list?[ind]??getNum(increment?(ind+1):ind);
          final bool isSelected=(val==value);
          return Center(child: AppText(text:val,
            color: isSelected?AppColors.whiteText:AppColors.grey5,
            fontWeight: isSelected?FontWeight.w600:FontWeight.w400,
            //fontsize: isSelected?24: 20,
            fontSize: AppSizer.getFontSize(20),
          ));
        },childCount: list?.length??count,),
    );
  }

  String getNum(int ind){
    return ind<=9?"0$ind":"$ind";
  }

  String formatTime12(int hour,int min){
    String tod=DateTimeUtil.TOD_AM;
    if(hour<=0){
      hour=12;
    }
    else if(hour==12){
      tod=DateTimeUtil.TOD_PM;
    }
    else if(hour>12){
      hour=hour-12;
      tod=DateTimeUtil.TOD_PM;
    }
    return "${getNum(hour)}:${getNum(min)} ${tod}";
  }



}