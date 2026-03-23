import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/presentaion/walletScreen/provider/walletProvider.dart';
import 'package:abldriver/widget/customPageRefresher.dart';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SettlementHistoryClass.dart';
import 'TransactionHistoryClass.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController amountController=TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WalletProvider>(context, listen: false).fetchwalletData();
    });
  }

  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
        builder: (context, provider, child) {
          return   Scaffold(
            appBar: CustomAppBar(title: 'Wallet', showBackButton: false,),
            backgroundColor: ColorResource.white,
            body: CustomPageRefresher(
                onRefresh: () async{
                  final provider =
                  Provider.of<WalletProvider>(context, listen: false);
                  await provider.fetchwalletData();
                },
                child:  SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 15,bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ColorResource.buttonBackground,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                'Available Balance',
                                size: 14,
                                weight: FontWeight.w600,
                                color: ColorResource.white,
                              ),
                              SizedBox(height: 10,),

                              CustomText(
                                "₹${provider.walletGetModel?.walletBalance ?? 0}",
                                size: 30,
                                color: ColorResource.white,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: const Color(0xFFC6C9C7),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            //textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter Amount',
                              contentPadding: EdgeInsets.only(left: 15,),
                              hintStyle: TextStyle(
                                color: Color(0xFF9B9B9B),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              // contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        CustomText(
                          "Your Minimum balance should be  ≥ 200'",
                          size: 8,
                          color: ColorResource.buttonBackground,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 10,),

                        PrimaryButton(
                          // title: 'Submit',
                          title: "Redeem",
                          onTap: () async {
                            await provider.PostWallet(
                              amount_requested: double.parse(amountController.text),

                            );

                            if (provider.error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(provider.postWalletResponse?.message ?? "")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(provider.postWalletResponse?.message ?? "")),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: 320,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 4,
                                offset: Offset(2, 2),
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              _tabButton(title: "Transaction history", index: 0),
                              _tabButton(title: "Settlement history", index: 1),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        selectedTab == 0
                            ? TransactionHistoryClass()
                            : SettlementHistoryClass(),


                      ],
                    ),
                  ),
                ),
            )



          );
        }
    );



  }
  Widget _tabButton({required String title, required int index}) {
    final bool isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF086B48) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : const Color(0xFF126E2E),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

}
