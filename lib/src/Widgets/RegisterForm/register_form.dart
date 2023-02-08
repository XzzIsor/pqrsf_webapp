import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pqrsf_webapp/src/Controllers/controllers.dart';
import 'package:pqrsf_webapp/src/Models/models.dart';
import 'package:pqrsf_webapp/src/Widgets/RegisterForm/status_dialog.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Transact newTransact = Transact(
      nombrePeticionario: '',
      idTipoTramite: -1,
      correo: '',
      numeroVU: -1,
      celular: '',
      fechaRecepcion: '',
      telefono: '',
      direccion: '',
      asunto: '',
      numeroOficio: '',
      idDependencia: -1,
      idTipoRecepcion: -1,
      descripcion: '',
      traza: [],
      idTipoTipoPeticionario: -1);
  String dateInitial = 'Fecha de Recepción';
  String dateFinal = 'Fecha de Venciomiento';
  @override
  Widget build(BuildContext context) {
    DataInfoController dataInfoController =
        Provider.of<DataInfoController>(context);
    dataInfoController.resetIndexes();
    List<String> tipoPeticionario = [];
    List<String> tipoDependencia = [];
    List<String> tipoPQRSF = [];
    List<String> tipoMedioRecepcion = [];

    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: dataInfoController.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            tipoPeticionario = dataInfoController.getPeticionaryTypes();
            tipoDependencia = dataInfoController.getDependencies();
            tipoPQRSF = dataInfoController.getTransactTypes();
            tipoMedioRecepcion = dataInfoController.getReceptionTypes();
          }

          return Form(
            key: _formKey,
            child: Container(
              height: size.height * 0.9,
              width: size.width * 0.85,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 4, 16, 102),
                      Color.fromARGB(255, 55, 92, 202),
                    ],
                    begin: FractionalOffset(0, 0.8),
                    end: FractionalOffset(0.8, 1),
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.aspectRatio * 25),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _column1(size, tipoPeticionario, tipoPQRSF),
                      _column2(size, tipoDependencia, tipoMedioRecepcion)
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  _saveButton(size, dataInfoController, context)
                ],
              ),
            ),
          );
        });
  }

  Widget _column1(
      Size size, List<String> tipoPeticionario, List<String> tipoPQRSF) {
    double heightS = size.height * 0.045;

    return Container(
      width: size.width * 0.25,
      margin: EdgeInsets.only(left: size.width * 0.1, top: heightS),
      child: Column(
        children: [
          CustomTextField(
            label: 'Número VU',
            icon: Icons.numbers,
            hintText: 'Ej: 123',
            onChange: (value) {
              if (int.tryParse(value) != null) {
                newTransact.numeroVU = int.parse(value);
              }
            },
            numberType: true,
            obscureText: false,
            validator: (value) {
              if (int.tryParse(value!) == null || value == '') {
                return "Ingrese un número válido";
              }
              return null;
            },
          ),
          SizedBox(height: heightS),
          _datePickerInitial(size),
          SizedBox(height: heightS),
          _datePickerFinal(size),
          SizedBox(height: heightS),
          CustomTextField(
            label: 'Peticionario',
            icon: Icons.person,
            hintText: 'Ej: Pepito Pérez',
            onChange: (value) {
              newTransact.nombrePeticionario = value;
            },
            numberType: false,
            obscureText: false,
            validator: (value) {
              if (value == null || value == '') {
                return "Ingrese un peticionario";
              }
              return null;
            },
          ),
          SizedBox(height: heightS),
          CustomDropdown(
              type: 2,
              items: tipoPeticionario,
              label: 'Seleccione un tipo de peticionario',
              iconColor: Colors.white,
              icon: Icons.person_pin_rounded),
          SizedBox(height: heightS),
          CustomDropdown(
            type: 4,
            items: tipoPQRSF,
            label: 'Seleccione un tipo de PQRSF',
            iconColor: Colors.white,
            icon: Icons.content_paste_go_sharp,
          ),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Asunto',
              icon: Icons.abc,
              hintText: 'Ej: Solicitud reintegro',
              onChange: (value) {
                newTransact.asunto = value;
              },
              numberType: false,
              obscureText: false,
              validator: (value) {
                if (value == null || value == '') {
                  return "Ingrese un asunto";
                }
                return null;
              }),
          SizedBox(height: heightS),
        ],
      ),
    );
  }

  Row _datePickerInitial(Size size) {
    return Row(
      children: [
        const Icon(
          Icons.calendar_month,
          color: Colors.white,
        ),
        SizedBox(
          width: size.width * 0.008,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.009),
          height: size.height * 0.05,
          width: size.width * 0.228,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateInitial,
                style: TextStyle(
                    color: Colors.black, fontSize: size.aspectRatio * 8),
              ),
              IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now());

                    setState(() {
                      if (date != null) {
                        DateFormat formatter = DateFormat("dd/MM/yy");
                        dateInitial = formatter.format(date);
                        DateTime aux = date.add(const Duration(days: 15));
                        dateFinal = formatter.format(aux);
                        DateFormat formatter2 = DateFormat("dd/MM/yyyy");
                        newTransact.fechaRecepcion = formatter2.format(date);
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.calendar_today_sharp,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Row _datePickerFinal(Size size) {
    return Row(
      children: [
        const Icon(
          Icons.calendar_month,
          color: Colors.white,
        ),
        SizedBox(
          width: size.width * 0.008,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.009),
          height: size.height * 0.05,
          width: size.width * 0.228,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFinal,
                style: TextStyle(
                    color: Colors.black, fontSize: size.aspectRatio * 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _column2(Size size, List<String> tipoDependencia,
      List<String> tipoMedioRecepcion) {
    double heightS = size.height * 0.045;
    return Container(
      width: size.width * 0.25,
      margin: EdgeInsets.only(left: size.width * 0.1, top: heightS),
      child: Column(
        children: [
          CustomDropdown(
            type: 1,
            items: tipoDependencia,
            label: 'Seleccione una Dependencia',
            iconColor: Colors.white,
            icon: Icons.location_city_rounded,
          ),
          SizedBox(height: heightS),
          CustomTextField(
            label: 'No. Oficio',
            icon: Icons.account_box_rounded,
            hintText: 'Ej: 123',
            onChange: (value) {
              newTransact.numeroOficio = value;
            },
            numberType: false,
            obscureText: false,
            validator: (value) {
              if (value == null || value == '') {
                return "Ingrese un número de oficio";
              }
              return null;
            },
          ),
          SizedBox(height: heightS),
          CustomTextField(
            label: 'Dirección',
            icon: Icons.maps_home_work,
            hintText: 'Ej: Carrera 16 #13-02',
            onChange: (value) {
              newTransact.direccion = value;
            },
            numberType: false,
            obscureText: false,
            validator: (value) {
              if (value == null || value == '') {
                return "Ingrese una dirección";
              }
              return null;
            },
          ),
          SizedBox(height: heightS),
          CustomTextField(
            label: 'Teléfono',
            icon: Icons.phone,
            hintText: 'Ej: 84348215',
            onChange: (value) {
              if (int.tryParse(value) != null) {
                newTransact.telefono = value;
              }
            },
            numberType: false,
            obscureText: false,
            validator: (value) {
              if (value == null || value == '' || int.tryParse(value) == null) {
                return "Ingrese un teléfono válido";
              }
              return null;
            },
          ),
          SizedBox(height: heightS),
          CustomTextField(
            label: 'Celular',
            icon: Icons.phone_android_outlined,
            hintText: 'Ej: 322684123',
            onChange: (value) {
              if (int.tryParse(value) != null) {
                newTransact.celular = value;
              }
            },
            numberType: false,
            obscureText: false,
            validator: (value) {
              if (value == null || value == '' || int.tryParse(value) == null) {
                return "Ingrese un teléfono válido";
              }
              return null;
            },
          ),
          SizedBox(height: heightS),
          CustomTextField(
            label: 'Correo Electrónico',
            icon: Icons.email,
            hintText: 'Ej: user@gmail.com',
            onChange: (value) {
              newTransact.correo = value;
            },
            numberType: false,
            obscureText: false,
            validator: (value) {
              RegExp exp = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              if (value == null ||
                  value == '' ||
                  exp.hasMatch(value) == false) {
                return "Ingrese un correo electrónico válido";
              }
              return null;
            },
          ),
          SizedBox(height: heightS),
          CustomDropdown(
            type: 3,
            items: tipoMedioRecepcion,
            label: 'Seleccione un Medio de Recepción',
            iconColor: Colors.white,
            icon: Icons.type_specimen,
          ),
          SizedBox(height: heightS),
        ],
      ),
    );
  }

  Widget _saveButton(
      Size size, DataInfoController controller, BuildContext context) {
    Color messageColor = Colors.black;
    Color buttonColor = Colors.white;

    TransactController transactController =
        Provider.of<TransactController>(context);

    return Align(
      child: SizedBox(
        width: size.width * 0.1,
        height: size.height * 0.08,
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate() &&
                controller.indexDependency != -1 &&
                controller.indexPeticionryType != 1 &&
                controller.indexReceptionType != -1 &&
                controller.indexTransactTypes != -1) {
              newTransact.idDependencia = controller.indexDependency;
              newTransact.idTipoTipoPeticionario =
                  controller.indexPeticionryType;
              newTransact.idTipoTramite = controller.indexTransactTypes;
              newTransact.idTipoRecepcion = controller.indexReceptionType;
              newTransact.descripcion = 'Descripción :v';

              bool res = await transactController.registerTransact(newTransact);
              if (res == true) {
                StatusDialog()
                    .showStatusDialog(context, 'Registro realizado con éxito');
              } else {
                StatusDialog()
                    .showStatusDialog(context, 'Problema al ingresar');
              }
            } else {
              StatusDialog()
                  .showStatusDialog(context, 'Complete todos los campos');
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 12,
            backgroundColor: buttonColor,
            foregroundColor: messageColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.aspectRatio * 12),
          ),
          child: const Text('Guardar'),
        ),
      ),
    );
  }
}
