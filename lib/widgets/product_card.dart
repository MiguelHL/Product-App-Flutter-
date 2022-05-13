import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30,bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children:[
            _BackgroundImage(product.picture),
            _ProductDetails(nameProduct: product.name,idProduct: product.id.toString(),),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(priceProduct: product.price,)
            ),
            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable(stateProduct: product.available,)
            ),
          ],
        ),
       // color: Colors.red,
      ),
    );
  }

BoxDecoration _cardBorders() {
    return BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const[
        BoxShadow(
          color: Colors.black,
          offset: Offset(0,7),
          blurRadius: 10
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class _NotAvailable extends StatelessWidget {

  _NotAvailable({required this.stateProduct});
  bool stateProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(stateProduct?'Habilitado':'No habilitado',style: const TextStyle( color: Colors.white, fontSize: 20),),
        ),
      ),
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight:Radius.circular(25))
      ),
    );
  }
}

// ignore: must_be_immutable
class _PriceTag extends StatelessWidget {

  _PriceTag({required this.priceProduct});
  double priceProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('$priceProduct',style: const TextStyle(color: Colors.white, fontSize: 20),)),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25))
      ),
    );
  }
}


class _BackgroundImage extends StatelessWidget {

  final String? url;
  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null 
        ? const Image(image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,)
        :FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit:BoxFit.cover,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ProductDetails extends StatelessWidget {

  _ProductDetails({required this.nameProduct,required this.idProduct});
  String nameProduct;
  String idProduct;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width: double.infinity,
        height: 70,
        // color: Colors.indigo,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(nameProduct,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),
            Text(idProduct,style: const TextStyle(fontSize: 15,color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),topRight: Radius.circular(25)) 
    );
  }
}