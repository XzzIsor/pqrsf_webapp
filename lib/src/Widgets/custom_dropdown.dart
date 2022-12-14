import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  CustomDropdown(
      {Key? key,
      required this.items,
      required this.label,
      this.iconColor,
      required this.icon})
      : super(key: key);

  final List items;
  final String label;
  final Color? iconColor;
  final IconData icon;
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.25,
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: widget.iconColor ?? Colors.black,
          ),
          SizedBox(width: size.width * 0.01),
          SizedBox(
            width: size.width * 0.226,
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black)),
              ),
              isExpanded: true,
              hint: Text(
                widget.label,
                style: TextStyle(
                    fontSize: size.aspectRatio * 8, color: Colors.black),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              iconSize: size.aspectRatio * 15,
              iconOnClick: const Icon(
                Icons.arrow_drop_up,
                color: Colors.black,
              ),
              buttonHeight: size.aspectRatio * 30,
              buttonPadding: const EdgeInsets.only(left: 0, right: 10),
              dropdownDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              buttonDecoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
              items: widget.items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: size.aspectRatio * 8,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Por favor ${widget.label}';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
            ),
          ),
        ],
      ),
    );
  }
}
