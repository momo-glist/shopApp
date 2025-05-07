import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provide.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvide>().cart;
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final cartItem = cart[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                  radius: 30,
                ),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Delete Product",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content: Text(
                                  "Are yous sure you want to remove the product of your cart?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      context.read<CartProvide>()
                                      .removeproduct(cartItem);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                title: Text(cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall),
                subtitle: Text('Size: ${cartItem['size']}'),
              );
            }));
  }
}
