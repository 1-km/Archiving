import 'package:cohalal/model/cart.dart';
import 'package:cohalal/model/product_list.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final ProductListViewModel productVm;
  final MyCartViewModel myCartVm;

  const ProductList(
      {required this.myCartVm, required this.productVm, super.key});
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.productVm.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(widget.productVm.products[index].productId),
            title: Text(widget.productVm.products[index].productName),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    widget.myCartVm
                        .addProduct(widget.productVm.products[index]);
                    debugPrint("from Cart : ${widget.myCartVm.items.length}");
                  });
                },
                icon: const Icon(Icons.shopping_cart)),
          );
        });
  }
}
