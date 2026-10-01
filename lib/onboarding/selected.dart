import 'package:flutter/material.dart';

class Selected extends StatefulWidget {
final bool isSelect;
final String? title;
final String? icon;
void Function()? onTap;

Selected({
super.key,
this.isSelect = true,
this.title,
this.icon,
required this.onTap,
});
Selected.icon({super.key,this.isSelect = true,
  this.title,
  this.icon,
  required this.onTap,});

  @override
  State<Selected> createState() => _SelectedState();
}

class _SelectedState extends State<Selected> {
@override
Widget build(BuildContext context) {
var theme = Theme.of(context);
return GestureDetector(
onTap: widget.onTap,
child: Padding(
padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
child: Container(
width: 78,
height: 32,
decoration: BoxDecoration(
border: Border.all(
color: theme.dividerColor,
),
color: widget.isSelect
? theme.primaryColor
    : theme.scaffoldBackgroundColor,
borderRadius: BorderRadius.circular(8),
),
child: Center(
child: widget.icon != null
? ImageIcon(
AssetImage(widget.icon!),
size: 24,
color: widget.isSelect ? Colors.white : theme.primaryColor,
)
    : Text(
widget.title!,
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.w600,
color: widget.isSelect
? Colors.white
    : theme.primaryColor,
),
),
),
),
),
);
}
}
