import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  List<String> tipoPeticionario = [
    'Estudiante de pregrado',
    'Estudiante de Posgrado',
    'Empleado',
    'Docente',
    'Egresado',
    'Jubilado',
    'Persona Externa'
  ];

  List<String> tipoDependencia = [
    'Dependencia 1',
    'Dependencia 2',
    'Dependencia 3',
    'Dependencia 4',
    'Dependencia 5'
  ];

  List<String> tipoPQRSF = [
    'Petición',
    'Queja',
    'Reclamo',
    'Sugerencia',
    'Felicitación'
  ];

  List<String> tipoMedioRecepcion = ['Web', 'Físico'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                      color: Colors.white, fontSize: size.aspectRatio * 25),
                ),
              ),
            ),
            Row(
              children: [_column1(size), _column2(size)],
            ),
            SizedBox(height: size.height * 0.01),
            _saveButton(size)
          ],
        ),
      ),
    );
  }

  Widget _column1(Size size) {
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
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Fecha de Recepción',
              icon: Icons.date_range_outlined,
              hintText: '',
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Fecha de Vencimiento',
              icon: Icons.date_range_sharp,
              hintText: '',
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Peticionario',
              icon: Icons.person,
              hintText: 'Ej: Pepito Pérez',
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomDropdown(
              items: tipoPeticionario,
              label: 'Seleccione un tipo de peticionario',
              iconColor: Colors.white,
              icon: Icons.person_pin_rounded),
          SizedBox(height: heightS),
          CustomDropdown(
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
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
        ],
      ),
    );
  }

  Widget _column2(Size size) {
    double heightS = size.height * 0.045;
    return Container(
      width: size.width * 0.25,
      margin: EdgeInsets.only(left: size.width * 0.1, top: heightS),
      child: Column(
        children: [
          CustomDropdown(
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
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Dirección',
              icon: Icons.maps_home_work,
              hintText: 'Ej: Carrera 16 #13-02',
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Teléfono',
              icon: Icons.phone,
              hintText: 'Ej: 84348215',
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Celular',
              icon: Icons.phone_android_outlined,
              hintText: 'Ej: 322684123',
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomTextField(
              label: 'Correo Electrónico',
              icon: Icons.email,
              hintText: 'Ej: user@gmail.com',
              onChange: (value) {},
              emailType: false,
              obscureText: false),
          SizedBox(height: heightS),
          CustomDropdown(
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

  Widget _saveButton(Size size) {
    Color messageColor = Colors.black;
    Color buttonColor = Colors.white;
    bool hover = false;

    return Align(
      child: SizedBox(
        width: size.width * 0.1,
        height: size.height * 0.08,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 12,
            primary: buttonColor,
            onPrimary: messageColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.aspectRatio * 12),
          ),
          onHover: ((value) {
            setState(() {
              hover = value;
              hover ? buttonColor = Colors.black : buttonColor = Colors.white;
              hover ? messageColor = Colors.white : buttonColor = Colors.black;
            });
          }),
          child: const Text('Guardar'),
        ),
      ),
    );
  }
}
