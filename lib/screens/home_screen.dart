import 'dart:convert';
import 'dart:ffi';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:final_distribuida/models/encuesta.dart';
import 'package:final_distribuida/models/user.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:final_distribuida/components/loader_component.dart';
import 'package:final_distribuida/helpers/constans.dart';
import 'package:final_distribuida/models/token.dart';
import 'package:final_distribuida/screens/home_screen.dart';
import 'package:final_distribuida/helpers/api_helper.dart';
import 'package:final_distribuida/models/response.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  final Token token;
  final String id;

  HomeScreen({required this.token, required this.id});
  @override
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = '';
  int qualification = 0;
  String theBest = '';
  String theWorst = '';
  String remarks = '';
  String emailError = '';
  String qualificationError = '';
  String theBestError = '';
  String theWorstError = '';
  String remarksError = '';
  bool emailShowError = false;
  bool qualificationShowError = false;
  bool theBestShowError = false;
  bool theWorstShowError = false;
  bool remarksShowError = false;
  bool _showLoader = false;
  Object dataEncuesta = {};
  TextEditingController emailController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController theBestController = TextEditingController();
  TextEditingController theWorstController = TextEditingController();
  void initState() {
    super.initState();
    _getEncuesta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenid@ ${widget.token.user.fullName}'),
      ),
      body: Stack(
        children: <Widget>[
          _getBody(),
        ],
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _showEmail(),
            _showDontLike(),
            _showLike(),
            _showRemarks(),
            _showQualification(),
            _showButtons()
          ],
        ),
      ),
    );
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Ingresa tu email...',
          labelText: 'Email',
          errorText: emailShowError ? emailError : null,
          prefixIcon: Icon(Icons.alternate_email),
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          email = value;
        },
      ),
    );
  }

  Widget _showLike() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'qu?? te gust?? de la materia?',
          labelText: 'lo que te gust?? de la materia',
          errorText: theBestShowError ? theBestError : null,
          prefixIcon: Icon(Icons.alternate_email),
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          theBest = value;
        },
      ),
    );
  }

  Widget _showDontLike() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Qu?? no te gust???',
          labelText: 'qu?? no te gust??',
          errorText: theWorstShowError ? theWorstError : null,
          prefixIcon: Icon(Icons.alternate_email),
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          theWorst = value;
        },
      ),
    );
  }

  Widget _showRemarks() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Comentarios',
          labelText: 'Comentarios',
          errorText: remarksShowError ? remarksError : null,
          prefixIcon: Icon(Icons.ac_unit_rounded),
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          remarks = value;
        },
      ),
    );
  }

  Widget _showQualification() {
    return Container(
      padding: EdgeInsets.all(10),
      child: RatingBar.builder(
        initialRating: 3,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          qualification = rating.toInt();
        },
      ),
    );
  }

  bool _validateFields() {
    bool isValid = true;

    if (email.isEmpty) {
      isValid = false;
      emailShowError = true;
      emailError = 'Debes ingresar tu email.';
    } else if (!EmailValidator.validate(email)) {
      isValid = false;
      emailShowError = true;
      emailError = 'Debes ingresar un email v??lido.';
    } else {
      emailShowError = false;
    }

    if (qualification == 0) {
      isValid = false;
      qualificationShowError = true;
      qualificationError = 'Debes diligenciar este campo';
    } else {
      qualificationShowError = false;
    }
    if (theBest.isEmpty) {
      isValid = false;
      theBestShowError = true;
      theBestError = 'Debes diligenciar este campo';
    } else {
      theBestShowError = false;
    }
    if (theWorst.isEmpty) {
      isValid = false;
      theWorstShowError = true;
      theWorstError = 'Debes diligenciar este campo';
    } else {
      theWorstShowError = false;
    }
    if (theWorst.isEmpty) {
      isValid = false;
      theWorstShowError = true;
      theWorstError = 'Debes diligenciar este campo';
    } else {
      theWorstShowError = false;
    }
    if (remarks.isEmpty) {
      isValid = false;
      remarksShowError = true;
      remarksError = 'Debes diligenciar este campo';
    } else {
      remarksShowError = false;
    }

    setState(() {});
    return isValid;
  }

  void _addEncuesta() async {
    if (!_validateFields()) {
      return;
    }

    setState(() {
      _showLoader = true;
    });

    Map<String, dynamic> request = {
      'email': email,
      'qualification': qualification,
      'theBest': theBest,
      'theWorst': theWorst,
      'remarks': remarks,
    };

    Response response =
        await ApiHelper.post('/api/Finals', request, widget.token);

    setState(() {
      _showLoader = false;
    });
    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    if (response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Se ha enviado la encuesta',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);

      return;
    }
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _showEncuestaButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showEncuestaButton() {
    return Expanded(
      child: ElevatedButton(
        child: Text('Guardar encuesta'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return Color(0xFF120E43);
          }),
        ),
        onPressed: () => _addEncuesta(),
      ),
    );
  }

  Future<Null> _getEncuesta() async {
    setState(() {
      _showLoader = true;
    });

    Response response = await ApiHelper.getEncuesta(widget.token);
    print(response);

    setState(() {
      _showLoader = false;
      dataEncuesta = response.result.encuesta;
    });
    print(dataEncuesta);

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
  }

  void _save() {
    if (!_validateFields()) {
      return;
    }

    widget.token.user.id.isEmpty ? _addEncuesta() : _getEncuesta();
  }
}
