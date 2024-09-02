import 'package:auto_size_text/auto_size_text.dart';
import 'package:baba_karkar/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextInpuAll extends StatefulWidget {
  TextEditingController? controller;
  String? label;
  bool? isPassword = false;
  TextInputType? type;
  IconData? prefixicon;
  IconData? suffixicon;
  TextInpuAll(
      {this.controller,
      this.isPassword,
      this.label,
      this.prefixicon,
      this.suffixicon,
      this.type});

  @override
  State<TextInpuAll> createState() => _TextInpuAllState();
}

class _TextInpuAllState extends State<TextInpuAll> {
  bool security = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: kPrimarycolor,
          colorScheme: ColorScheme.light(primary: kPrimarycolor)),
      child: TextFormField(
        maxLines: widget.label == AppLocalizations.of(context)!.texthomework ||
                widget.label == AppLocalizations.of(context)!.textnotifications
            ? 4
            : 1,
        controller: widget.controller,
        cursorColor: kPrimarycolor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.requiredfield;
          } else if (widget.label == "Email address") {
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return AppLocalizations.of(context)!.emailvalidate;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIconColor: kPrimarycolor,
          suffixIcon: widget.isPassword!
              ? security
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          security = !security;
                        });
                      },
                      child: Icon(
                        Icons.visibility_off,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          security = !security;
                        });
                      },
                      child: Icon(
                        Icons.visibility,
                      ),
                    )
              : null,
          labelStyle: TextStyle(fontSize: 14),
          label: AutoSizeText(
            widget.label!,
            minFontSize: 14,
            maxFontSize: 18,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimarycolor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: kPrimarycolor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        obscureText: widget.isPassword! ? security : false,
      ),
    );
  }
}
