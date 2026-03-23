import 'package:abldriver/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/customInputBox.dart';
import '../../../widget/custom_App_bar.dart';
import '../provider/accountProvider.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  TextEditingController bankNameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
        builder: (context, provider, child) {
          return  Scaffold(
            appBar: CustomAppBar(title: 'Account Details'),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomInputField1(
                      hintText: 'Bank Name',
                      controller: provider.bankNameController,
                    ),
                    SizedBox(height: 10,),
                    CustomInputField1(
                      hintText: 'Branch Name',
                      controller: provider.branchNameController,
                    ),
                    SizedBox(height: 10,),
                    CustomInputField1(
                      hintText: 'Account Holder Name',
                      controller: provider.benificiaryNameController,
                    ),
                    SizedBox(height: 10,),
                    CustomInputField1(
                      hintText: 'Account Number',
                      controller: provider.accountNoController,
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    SizedBox(height: 10,),
                    CustomInputField1(
                      hintText: 'Re- Account Number',
                      controller: provider.reAccountNoController,
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    SizedBox(height: 10,),
                    CustomInputField1(
                      hintText: 'IFCS Code',
                      controller: provider.ifscController,
                    ),
                    SizedBox(height: 10,),
                   
                    PrimaryButton(
                        title: provider.isLoading ? 'Updating...' : 'Update',
                        onTap: (){
                          provider.updateAccount(context);
                        }
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );



  }
}
