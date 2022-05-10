import 'package:flutter/material.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:products_app/ui/input_decorations.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children:[
                  ProductImage(),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton( 
                      icon:const Icon(Icons.arrow_back_ios),
                      onPressed: ()=> Navigator.of(context).pop()
                      ),
                  ),
                   Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton( 
                      icon:const Icon(Icons.camera_alt_outlined),
                      onPressed: (){
                        // Todo:Camara y galeria
                      }
                      ),
                  )
                 
              ],
            ),
            _ProductForm(),
            const SizedBox(height: 150,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_alt_outlined),
        onPressed:(){} ,
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
        width: double.infinity,
        height: 280,
        decoration: _buildBoxDecoration(),

        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del producto', 
                    labelText: 'Nombre'
                  ),
                ),
              ),
              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '150', 
                    labelText: 'Precio'
                  ),
                ),
              ),
              const SizedBox(height: 30,),

              SwitchListTile.adaptive(
                title: const Text('Disponible'),
                value: true, 
                onChanged: (value){
                  // Todo : pendiente
                }
              ),
              const SizedBox(height: 30,),
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return  BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0,5),
          blurRadius: 5
        )
      ]
    );
  }
}