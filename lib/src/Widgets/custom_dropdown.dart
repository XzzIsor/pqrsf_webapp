import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/controllers.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    Key? key,
    required this.items,
    required this.label,
    this.iconColor,
    required this.icon,
    required this.type,
  }) : super(key: key);

  final List<String> items;
  final String label;
  final Color? iconColor;
  final IconData icon;
  final int type;
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DataInfoController dataInfoController =
        Provider.of<DataInfoController>(context);
    final formKey = GlobalKey<FormState>();

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
              key: formKey,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black)),
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
                if (value == widget.label) {
                  return 'Por favor ${widget.label}';
                }
                return null;
              },
              onChanged: (value) {
                int index = widget.items.indexOf(value.toString());

                if (widget.type == 1) {
                  dataInfoController.indexDependency = index + 1;
                }

                if (widget.type == 2) {
                  dataInfoController.indexPeticionryType = index + 1;
                }

                if (widget.type == 3) {
                  dataInfoController.indexReceptionType = index + 1;
                }

                if (widget.type == 4) {
                  dataInfoController.indexTransactTypes = index + 1;
                }
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
