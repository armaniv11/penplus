import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:penon/appconstants.dart';
import 'package:penon/custom_widgets/widgets.dart';
import 'package:penon/models/ledger_model.dart';
import 'package:penon/models/invoice_model.dart';
import 'package:penon/models/pay_receive_model.dart';
import 'package:penon/screens/employee/add_payment_receive.dart';
import 'package:penon/screens/registers/components/invoice_itemlist_bottomsheet.dart';

import '../../employee/add_receive.dart';

class LedgerList extends StatefulWidget {
  final LedgerModel invoice;
  final int index;
  const LedgerList({Key? key, required this.invoice, required this.index})
      : super(key: key);

  @override
  _LedgerListState createState() => _LedgerListState();
}

class _LedgerListState extends State<LedgerList> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("${widget.invoice.transactionType} this is in the list");
    print(widget.invoice.invoiceId);
    Size size = MediaQuery.of(context).size;
    final transType = widget.invoice.transactionType;
    String invDate = widget.invoice.invoiceDate == null
        ? "No Date"
        : Jiffy(widget.invoice.invoiceDate.toString()).yMMMd;

    return GestureDetector(
      onTap: () async {
        if (transType == AppConstants.purchaseTransaction ||
            transType == AppConstants.saleTransaction) {
          await FirebaseFirestore.instance
              .collection('Invoices')
              .doc(widget.invoice.invoiceId)
              .get()
              .then((value) {
            showModalBottomSheet(
              isScrollControlled: true,
              // isDismissible: true,
              context: context,
              builder: (context) {
                return InvoiceItemListBottomSheet(
                    invoice: InvoiceModel.fromJson(
                        value.data() as Map<String, dynamic>)

                    // callback: changeCart,
                    );
              },
            );
          });
        } else {
          await FirebaseFirestore.instance
              .collection(transType)
              .doc(widget.invoice.invoiceId)
              .get()
              .then((value) {
            print("${value} printing value");
            PayReceiveModel payReceiveModel =
                PayReceiveModel.fromJson(value.data() as Map<String, dynamic>);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPayment(
                          updatePayReceive: payReceiveModel,
                          transaction: payReceiveModel.transactionType,
                        )));
            // } else {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => AddReceive()));
            // }
          });
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.only(left: 4, right: 4),
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text(
                    widget.index.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                    height: 26,
                    child: VerticalDivider(
                      color: Colors.blue,
                      width: 6,
                      thickness: 1,
                    )),
                SizedBox(
                  width: size.width * 0.40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.invoice.partyId.partyName!,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(invDate)
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(right: 2),
                    width: size.width * 0.25,
                    color: Colors.orange[100],
                    height: 40,
                    child: iconWithText(FontAwesomeIcons.rupeeSign, 10,
                        widget.invoice.creditAmount.toString(),
                        fontsize: 14,
                        mainAxisAlignment: MainAxisAlignment.end)),
                Container(
                    padding: const EdgeInsets.only(right: 2),
                    color: Colors.green[100],
                    height: 40,
                    width: size.width * 0.25,
                    child: iconWithText(FontAwesomeIcons.rupeeSign, 10,
                        widget.invoice.debitAmount.toString(),
                        fontsize: 14, mainAxisAlignment: MainAxisAlignment.end))
              ],
            )),
      ),
    );
  }
}
