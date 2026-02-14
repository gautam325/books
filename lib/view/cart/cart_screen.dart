import 'package:books/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Obx(
        () => cart.items.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (_, index) {
                        final item = cart.items[index];
                        return ListTile(
                          title: Text(item.book.title),
                          subtitle: Text('\$${item.book.price.toStringAsFixed(2)} x ${item.quantity}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: () => cart.decreaseQty(item.book.id), icon: const Icon(Icons.remove)),
                              IconButton(onPressed: () => cart.increaseQty(item.book.id), icon: const Icon(Icons.add)),
                              IconButton(onPressed: () => cart.removeFromCart(item.book.id), icon: const Icon(Icons.delete)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: cart.checkout, child: const Text('Checkout')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
