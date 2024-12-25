import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order, 
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.51,
          decoration: BoxDecoration(color: const Color.fromARGB(255,255, 113, 205), borderRadius: BorderRadius.circular(8), 
          border: Border.all(color: Colors.white, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${order.id}')
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 139, 147, 255), borderRadius: BorderRadius.circular(8), 
                  border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Стоимость заказа: ${order.total}', style: const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}