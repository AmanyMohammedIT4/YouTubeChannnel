import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/core/viewModel/auth_view_model.dart';
import 'package:gard/views/widgets/input_decoration.dart';
import 'package:get/get.dart';

class LoginView extends GetWidget<AuthViewModel> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapurpura(size),
            iconopersona(),
            loginform(context),
          ],
        ),
      ),
    );
  }
  

  SingleChildScrollView loginform(BuildContext context) {
    // final Userprovider = Provider.of<User_provider>(context);
    // final Userprovider = User_provider(widget.id);
    // Userprovider.getusers(widget.id);
 final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 200),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'تسجيل الدخول',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 30),
                Form(
                  key:_formKey ,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        // cursorColor: Colors.red,
                        decoration: InputDecorations.inputDecoration(
                          hintext: '',
                          labeltext: 'الايميل',
                          icono: const Icon(
                            Icons.person,
                            // color: IconColor,
                            color: Color.fromARGB(255, 137, 207, 190),
                          ),
                        ),
                        onSaved: (value){
                          controller.email=value;
                        },
                         validator: (value){
                            if(value==null || value.isEmpty){
                              return 'الرجاء ادخال الايميل';
                            }
                            else if(!value.contains('@')){
                              return 'الرجاء ادخال ايميل صحيح';
                            }
                            return null;
                          },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecorations.inputDecoration(
                          hintext: '',
                          labeltext: ('كلمة المرور'),
                          icono: const Icon(
                            Icons.lock_outline,
                            // color: IconColor,
                            color: Color.fromARGB(255, 137, 207, 190),
                          ),
                        ),
                        onSaved: (value){
                          controller.password=value;
                        },
                        validator: (value) {
                          return (value != null && value.length >= 3)
                              ? null
                              : 'يجب ان لا تكون كلمه المرور اقل من6  ارقام';
                        },
                      ),
                      const SizedBox(height: 30),
                      // buildUserName(),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        color: kbutton,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: ()async {
                          await AuthViewModel.isInternet().then((connection){
                          if(connection){
                             _formKey.currentState!.save();
                          if(_formKey.currentState!.validate()){
                            controller.signInWithEmailPassword();
                          }
                            print("Internet connection abailale");
                          }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("لايوجد انترنت ")));
                              }
                        });
                          
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  SafeArea iconopersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

   Container cajapurpura(Size size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          // Color.fromARGB(255, 63, 156, 83),
          // Color.fromARGB(255, 70, 178, 79),
          Color.fromARGB(255, 38, 138, 113),
          Color.fromARGB(255, 112, 219, 192),
        ]),
      ),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            child: burbuja(),
            top: -40,
            left: 30,
          ),
          Positioned(child: burbuja(), top: 90, left: 30),
          Positioned(child: burbuja(), top: -50, right: -20),
          Positioned(child: burbuja(), bottom: -50, left: 10),
          Positioned(child: burbuja(), bottom: 120, right: 20),
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }

}


