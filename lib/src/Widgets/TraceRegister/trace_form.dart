import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Controllers/controllers.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';
import 'package:provider/provider.dart';

class TraceForm extends StatefulWidget {
  const TraceForm({Key? key}) : super(key: key);

  @override
  State<TraceForm> createState() => _TraceFormState();
}

class _TraceFormState extends State<TraceForm> {
  final formKey = GlobalKey<FormState>();
  List<String> dependencies = [];
  String numOficio = "";
  String description = "";
  String dependency = "";
  String message = "";

  @override
  Widget build(BuildContext context) {
    String numeroVU = ModalRoute.of(context)!.settings.arguments.toString();
    DataInfoController dataInfoController =
        Provider.of<DataInfoController>(context);
    TransactController transactController =
        Provider.of<TransactController>(context);
    Size size = MediaQuery.of(context).size;
    dataInfoController.resetIndexes();

    return FutureBuilder(
        future: dataInfoController.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dependencies = dataInfoController.getDependencies();
            return Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                    height: size.height * 0.7,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: size.width * 0.25,
                          child: _column1(dependencies, size, numeroVU,
                              dataInfoController, transactController),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.white,
              ),
            );
          }
        });
  }

  Column _column1(List<String> dependencies, Size size, String numVU,
      DataInfoController controller, TransactController transactController) {
    return Column(
      children: [
        Text(
          'Información \n Traza',
          style: TextStyle(
              color: Colors.black,
              fontSize: size.longestSide / size.shortestSide * 25,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          'Número VU: $numVU',
          style: TextStyle(
              color: Colors.black,
              fontSize: size.longestSide / size.shortestSide * 15,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        CustomDropdown(
            items: dependencies,
            label: dependencies[0],
            icon: Icons.location_city_rounded,
            type: 1),
        SizedBox(
          height: size.height * 0.02,
        ),
        CustomTextField(
          label: 'Número de Oficio',
          icon: Icons.numbers,
          hintText: "######",
          onChange: (value) {
            numOficio = value;
          },
          numberType: false,
          obscureText: false,
          iconColor: Colors.black,
          validator: (p0) {
            if (p0 == "" || p0 == null) {
              return "Ingrese un número de oficio";
            }
            return null;
          },
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        CustomTextField(
            label: 'Descripción',
            icon: Icons.text_fields_sharp,
            hintText: "Help",
            onChange: (value) {
              description = value;
            },
            numberType: false,
            obscureText: false,
            iconColor: Colors.black,
            validator: (p0) {
              if (p0 == "" || p0 == null) {
                return "Ingrese una descripción";
              }
              return null;
            }),
        SizedBox(
          height: size.height * 0.05,
        ),
        ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate() &&
                  controller.indexDependency != -1) {
                bool res = await transactController.registerTrace(
                    int.parse(numVU),
                    controller.indexDependency,
                    numOficio,
                    description);
                if (res) {
                  setState(() {
                    message = "Traza actualizada";
                  });
                } else {
                  setState(() {
                    message = "Error al registrar la traza";
                  });
                }
              }
            },
            style: ElevatedButton.styleFrom(
                elevation: 12,
                backgroundColor: const Color.fromRGBO(24, 47, 115, 1),
                fixedSize: Size(size.width * 0.1, size.height * 0.05),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: Text(
              'Agregar',
              style: TextStyle(
                  fontSize: size.aspectRatio * 15, fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: size.aspectRatio * 8),
        )
      ],
    );
  }
}
