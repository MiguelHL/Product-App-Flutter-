import 'package:flutter/material.dart';
import 'package:products_app/providers/login_provider.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children:[
              const SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Ingreso',style: Theme.of(context).textTheme.headline4,),
                    const SizedBox(height: 10,),

                    ChangeNotifierProvider(
                      create:(_)=> LoginFormProvider(),
                      child: const _LogiForm(),
                    ), 
                     
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  
                ),
                onPressed: ()=> Navigator.pushReplacementNamed(context, 'register'), 
                child: const Text('Crear una nueva cuenta',style: TextStyle(fontSize: 18),)
                ),
              
              const SizedBox(height: 50,),

            ],
          ) ,
        )
      ),
      );
  }
}

class _LogiForm extends StatelessWidget {
  const _LogiForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
  final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key:loginForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'name@gmail.com',
              labelText: 'Correo electronico',
              prefixIcon: Icons.email_outlined
            ),
            onChanged: (value)=> loginForm.email=value,
            validator: (value){
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? '')? null : 'el correo no es correcto';
            },
          ),
          const SizedBox(height: 30,),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*********',
              labelText: 'Contrase??a',
              prefixIcon: Icons.lock_outline
            ),
            onChanged: (value) => loginForm.password=value,
            validator: (value){
              if(value != null && value.length >=6) return null;
              return 'La contrase??a debe ser de 6 caracterres';
            },
          ),
          const SizedBox(height: 30,),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
              child: Text(loginForm.isLoading?'Espere':'Ingresar',style: const TextStyle(color: Colors.white),),
            ),
            onPressed: loginForm.isLoading?null:()async{

              FocusScope.of(context).unfocus();
              if(!loginForm.isValidForm()) return;
              loginForm.isLoading=true;
              await Future.delayed(const Duration(seconds: 2));

              loginForm.isLoading=false;

              Navigator.pushReplacementNamed(context, 'home');

            },
          )
        ],
      )
    );
  }
}