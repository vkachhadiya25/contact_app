import 'dart:io';

import 'package:calculater_app/model/contect_model.dart';
import 'package:calculater_app/provider/theme_provider.dart';
import 'package:calculater_app/utils/shr_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/add_contact_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController txtFName = TextEditingController();
  TextEditingController txtSName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  AddContactProvider? providerW;
  AddContactProvider? providerR;

  @override
  Widget build(BuildContext context) {
    providerW = context.watch<AddContactProvider>();
    providerR = context.read<AddContactProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()async
          {
            bool? isLogin=await providerR!.bioMatrix();
            if(isLogin != null)
              {
                if(isLogin == true)
                  {
                    providerR!.isPrivate = true;
                    Navigator.pushNamed(context, 'hideContact');
                  }
              }
          },icon: const Icon(Icons.visibility),),
          title: const Text("Contact"),
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, value1, child) => Switch(
                value: value1.isLight,
                onChanged: (value) {
                  ShareHelper shr = ShareHelper();
                  shr.setTheme(value);
                  value1.themeData();
                },
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: providerW!.addDataList.length,
          itemExtent: 100,
          itemBuilder: (context, index) {
            return Consumer(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    providerR!.storeIndex(index);
                    Navigator.pushNamed(context, 'update',
                        arguments: providerR!.addDataList[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                child: Column(
                                  children: [
                                    providerW!.addDataList[index].image != null
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundImage: FileImage(File(
                                                "${providerW!.addDataList[index].image}")),
                                          )
                                        : Container(
                                            height: 50,
                                            width: 50,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black),
                                            child: Text(
                                              "${providerW!.addDataList[index].fName!.isNotEmpty ? providerW!.addDataList[index].fName?.substring(0, 1).toUpperCase() : 0}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${providerW!.addDataList[index].fName}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${providerW!.addDataList[index].phone}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'addContact');
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
