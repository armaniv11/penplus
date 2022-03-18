import 'dart:io';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

Widget saveButton(text) {
  return Center(
    child: Container(
      width: double.maxFinite,
      height: 80,
      child: Center(
          child: new Text(text,
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0))),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                const Color.fromRGBO(236, 60, 3, 1),
                Color.fromRGBO(234, 60, 3, 1),
                const Color.fromRGBO(216, 78, 16, 1),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter),
          boxShadow: [
            const BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.16),
              offset: const Offset(0, 5),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(9.0)),
    ),
  );
}

Widget imgColumn(local, netimage, imgalias, height, width) {
  if (local != null || netimage != '') {
    return Column(
      children: [
        Stack(children: <Widget>[
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: Colors.red,
                image: local == null
                    ? DecorationImage(
                        image: NetworkImage(netimage), fit: BoxFit.fill)
                    : DecorationImage(
                        image: FileImage(local), fit: BoxFit.fill)),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         aadhar = null;
          //       });
          //     },
          //     child: Container(
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //             color: Colors.black),
          //         padding: EdgeInsets.all(6),
          //         child: Icon(Icons.clear, color: Colors.red)),
          //   ),
          // )
        ]),
      ],
    );
  } else {
    return Container();
  }
}

customButton(buttonName,
    {width = double.maxFinite,
    bool custompaddingVertical = false,
    double containerHeight = 60,
    Color color = Colors.white,
    backgroundColor = Colors.yellow,
    double fontsize = 18,
    double padding = 8,
    icon = null,
    IconData iconData = Icons.arrow_forward,
    Color iconColor = Colors.white}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: containerHeight,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor[900]),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonName,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: fontsize),
            ),
            icon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      iconData,
                      color: iconColor,
                    ),
                  )
                : Container()
          ],
        )),
      ),
    ),
  );
}

Widget customTextFormField(controller, hinttext, icon,
    {width = double.maxFinite,
    inputtype = TextInputType.name,
    maxlines = 1,
    maxlength = 15,
    Color headingColor = Colors.yellow,
    bool isDense = true,
    double headingsize = 14,
    bool validationEnabled = false,
    bool enabled = true,
    bool reverted = false,
    ValueChanged<String>? changed,
    String suffixText = ""}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    child: Container(
      width: width,

      // padding: EdgeInsets.only(bottom: 4, top: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: TextFormField(
            validator: (value) {
              if (validationEnabled) {
                return value!.isEmpty ? "$hinttext cannot be empty!!" : null;
              }
              return null;
            },
            textCapitalization: TextCapitalization.sentences,
            enabled: enabled,
            maxLines: maxlines == 1 ? null : maxlines,
            maxLength: maxlength == 15 ? null : maxlength,
            keyboardType: inputtype,
            controller: controller,
            style: TextStyle(color: !enabled ? Colors.grey : Colors.black),
            decoration: InputDecoration(
                label: Text(hinttext),
                suffixText: suffixText,
                labelStyle: const TextStyle(color: Colors.black),
                errorStyle: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
                prefixIcon: icon,
                filled: false,
                isDense: true,
                border: InputBorder.none),
            onChanged: (val) {
              if (reverted) {
                changed!(val);
              }
            }),
      ),
    ),
  );
}

Widget customTextFormFieldWithoutHeading(
  controller,
  hinttext,
  icon, {
  width = double.maxFinite,
  inputtype = TextInputType.name,
  maxlines = 1,
  maxlength = 15,
  Color? headingColor = Colors.yellow,
  bool isDense = true,
  double headingsize = 14,
  bool enabled = true,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          enabled: enabled,
          maxLines: maxlines == 1 ? null : maxlines,
          maxLength: maxlength == 15 ? null : maxlength,
          keyboardType: inputtype,
          controller: controller,
          style: TextStyle(color: !enabled ? Colors.grey : Colors.black),
          decoration: InputDecoration(
              labelText: hinttext,
              prefixIcon: icon,
              // filled: true,
              isDense: false,
              border: InputBorder.none),
          onChanged: (val) {}),
    ),
  );
}

Widget iconWithText(IconData iconname, double iconsize, String name,
    {Color color = Colors.black,
    double fontsize = 18,
    TextDecoration textDecoration = TextDecoration.none,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    FontWeight fontWeight = FontWeight.w900}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: mainAxisAlignment,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Icon(
          iconname,
          size: iconsize,
          color: Colors.grey,
        ),
      ),
      Text(
        name,
        overflow: TextOverflow.visible,
        style: TextStyle(
          decoration: textDecoration,
          fontSize: fontsize,
          color: color,
          fontWeight: fontWeight,
        ),
      )
    ],
  );
}

Widget textWithIcon(IconData iconname, double iconsize, String name,
    {Color color = Colors.black}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.green),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 12, color: color, fontWeight: FontWeight.bold),
        ),
        FaIcon(
          iconname,
          size: iconsize,
          color: Colors.white,
        ),
      ],
    ),
  );
}

Widget customText(String textname,
    {double size = 18,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    textname,
    style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    overflow: TextOverflow.ellipsis,
  );
}

Widget containerText(String text) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            const BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(9.0)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
      ));
}

Widget customCircularIcon(Color bgcolor, Color iconColor, IconData icon,
    {double size = 22}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Container(
      decoration: BoxDecoration(color: bgcolor, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Center(
          child: FaIcon(
            icon,
            size: size,
            color: iconColor,
            // size: 40,
            // color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
