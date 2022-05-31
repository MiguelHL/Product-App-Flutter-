import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_app/providers/product_form_provider.dart';
import 'package:products_app/services/product_service.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create:(_)=> ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService,),
    );
    //return _ProductScreenBody(productService: productService);
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body:SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children:[
                  ProductImage(url:productService.selectedProduct.picture,),
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
        onPressed:() async{
          if(!productForm.isValidForm()) return;
          await productService.saveOrCreateProduct(productForm.product); 
        } ,
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
        width: double.infinity,
        height: 280,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  initialValue: product.name,
                  onChanged: (value)=> product.name=value,
                  validator: (value){
                    if(value == null || value.isEmpty ){
                      return 'El nombre es obligatorio';
                    }
                  },
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
                  initialValue: product.price.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    if(double.tryParse(value)==null){
                      product.price=0;
                    }else{
                      product.price=double.parse(value);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                  ],
                  validator: (value){
                    if(value == null || value.isEmpty ){
                      return 'El nombre es obligatorio';
                    }
                  },
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '150', 
                    labelText: 'Precio'
                  ),
                ),
              ),
              const SizedBox(height: 30,),

              SwitchListTile.adaptive(
                title: const Text('Disponible'),
                value: product.available, 
                onChanged: (value){
                  productForm.updateAvailability(value);
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