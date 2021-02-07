import 'package:flutter/material.dart';
import 'package:ovenapp/Publics/AppStyle.dart';

class AppTextField extends StatefulWidget {
  AppTextField(
      {Key key,
      this.title,
      this.textController,
      this.margin=EdgeInsets.zero,
      this.clFocusBorderSide = AppStyle.mainColor,
      this.clLostBorderSide = AppStyle.clTFBorder,
      this.hint = '',
      this.tt = TextInputType.text,
      this.dLineHeight = 45.0,
      this.ispwd=false,
      this.af = false})
      : super(key: key);

  final String title;
  final String hint;
  final double dLineHeight;
  final TextEditingController textController;
  final TextInputType tt;
  final bool af;
  final Color clFocusBorderSide;
  final Color clLostBorderSide;
  final EdgeInsets margin;
final bool ispwd;
  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode _focusNode = FocusNode();
  Color clLine = AppStyle.clTitle1FC;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        clLine = widget.clFocusBorderSide;
      }
      if (!_focusNode.hasFocus) {
        clLine = widget.clLostBorderSide;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.dLineHeight,
      margin: widget.margin,//EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: clLine, width: 1.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 8.0),
            child: Text(widget.title, style: TextStyle(
                  fontSize: 18,
                  color: AppStyle.clButtonGray,
                ),),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.left,
              controller: widget.textController,
              // scrollPadding: EdgeInsets.all(0.0),
              // keyboardType: TextInputType.number,
              style: TextStyle(
                color: AppStyle.clTitle1FC,
                fontSize: 20.0,
                height: 1.3,
              ),
              decoration: InputDecoration(
                // prefixIcon: Icon(
                //   Icons.phone,
                //   color: AppStyle.cpCloseColor,
                // ),
                // prefixText: widget.title,
                // prefixStyle: TextStyle(
                //   fontSize: 18,
                //   color: AppStyle.clButtonGray,
                // ),
                // // helperText: "Yesterday Once More ...",color: Colors.red,
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                //helperText: '帐号/手机号',
                // border: OutlineInputBorder(),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: AppStyle.lightColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide.none,
                ),
                // border: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.red, //边框颜色为绿色
                //     width: 5, //宽度为5
                //   ),
                // ),
                // filled: true,
              ),
              keyboardType: widget.tt,
              autofocus: widget.af,
              focusNode: _focusNode,
              obscureText: widget.ispwd,
            ),
          ),

        ],
      ),
      //   ),
      // ],
      // ),
    );
  }
}
