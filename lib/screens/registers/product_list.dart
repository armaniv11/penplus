import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:penon/controllers/partyController.dart';
import 'package:penon/database/database.dart';
import 'package:penon/models/invoice_model.dart';
import 'package:penon/models/item_model.dart';
import 'package:penon/screens/registers/components/listview_register.dart';

import '../../controllers/itemController.dart';

class ProductRegister extends StatefulWidget {
  const ProductRegister({
    Key? key,
  }) : super(key: key);

  @override
  _ProductRegisterState createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {
  final ItemController itemController = Get.find();
  // TextEditingController partyNameController = TextEditingController();
  // TextEditingController gstNoController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController mobController = TextEditingController();
  // TextEditingController openingBalanceController =
  //     TextEditingController(text: '0');

  bool isLoading = false;

  List<ItemModel> ItemRegister = [];

  @override
  void initState() {
    // loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.blue[200]!.withOpacity(0.4),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Products "),
          elevation: 0,
        ),
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: GetX<ItemController>(builder: (controller) {
              return ListView.builder(
                  itemCount: controller.allItems.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: ListTile(
                        tileColor: Colors.white,
                        leading: Text("${index + 1}"),
                        title: Text(controller.allItems[index].itemName),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    );
                  });
            })),
      ),
    );
  }
}
