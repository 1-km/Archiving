import 'package:cohalal/model/cart.dart';
import 'package:cohalal/s_cart.dart';
import 'package:cohalal/s_product_list.dart';
import 'package:cohalal/model/product_list.dart';
import 'package:cohalal/statefulwidget_test.dart';
import 'package:cohalal/statelesswidget_test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ProductListViewModel productVm = ProductListViewModel();
  final MyCartViewModel cartVm = MyCartViewModel();
  int _index = 0;
  @override
  void initState() {
    // cartVm.onItemsUpdated = () {
    //   setState(() {});
    // };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        // backgroundColor: Colors.grey,
        appBar: buildAppbar(cartVm),
        body: IndexedStack(
          index: _index,
          children: [
            ProductList(productVm: productVm, myCartVm: cartVm),
            MyCart(myCartVm: cartVm),
            // const StatefulTest(),
            // StatelessTest(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.amber,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: '상품'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: '장바구니'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.science), label: 'Stateful'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.science), label: 'Stateless'),
          ],
          currentIndex: _index,
          onTap: (newIndex) {
            setState(() {
              _index = newIndex;
            });
          },
        ),
      )),
    );
  }
}

AppBar buildAppbar(MyCartViewModel myCartVm) {
  debugPrint("from AppBar : ${myCartVm.items.length}");
  return AppBar(
    title: const Text('Daino 쇼핑'),
    actions: [
      Center(
        child: Stack(
          children: [
            const Icon(Icons.shopping_cart),
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.redAccent,
                child: Text('${myCartVm.items.length}'),
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        width: 15,
      )
    ],
  );
}
