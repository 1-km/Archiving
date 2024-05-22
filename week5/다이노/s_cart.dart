import 'package:cohalal/model/cart.dart';
import 'package:flutter/material.dart';

class MyCart extends StatelessWidget {
  final MyCartViewModel myCartVm;

  const MyCart({required this.myCartVm, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.blueAccent,
            ),
            Text(
              '${myCartVm.items.length} 개',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
