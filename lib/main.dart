import 'package:flutter/material.dart';
import 'invoice.dart';
import 'product.dart';

void main() {
  runApp(
      MaterialApp(
        home: MainPage(),
      )
  );
}
TextEditingController cnameController = TextEditingController();
TextEditingController pnameController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController quantityController = TextEditingController();

class MainPage extends StatefulWidget {
List<Product> products = [];
List<Invoice> invoices = [];
int invoiceNo = 1;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Product Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: false,
                controller: pnameController,
                decoration: InputDecoration(
                  labelText: 'product name',
                ),
              ),
              TextField(
                autofocus: false,
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'price',
                ),
              ),
              TextField(
                autofocus: false,
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'quantity',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  widget.products.add(Product(name: pnameController.text, price: double.parse(priceController.text), quantity: int.parse(quantityController.text)));
                  Navigator.of(context).pop();
                  setState(() {

                  });
                },
                child: Text('add')
            ),
            ElevatedButton(

                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel')
            ),
          ],
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice# ${widget.invoiceNo}'),
      ),
      body: Column(
        children: [
          TextField(
            autofocus: false,
            controller: cnameController,
            decoration: InputDecoration(
              labelText: 'customer name',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Products:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              ElevatedButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Text('add product')
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.blue,
                      leading: Text(widget.products[index].name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                      title: Text('price: ${widget.products[index].price}'),
                      subtitle: Text('Quantity: ${widget.products[index].quantity}'),
                      trailing: IconButton(
                        onPressed: () {

                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(

                  onPressed: () {
                    widget.invoices.add(
                      Invoice(widget.invoiceNo++,cnameController.text,widget.products)
                    );
                    cnameController.clear();
                    widget.products = [];
                    setState(() {

                    });
                  },
                  child: Text('add invoice')
              ),
              ElevatedButton(

                  onPressed: () {

                  },
                  child: Text('show all invoices')
              ),
            ],
          ),
        ],
      ),
    );
  }
}