import 'dart:io';

import 'package:calculater_app/provider/add_contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HideContactScreen extends StatefulWidget {
  const HideContactScreen({super.key});

  @override
  State<HideContactScreen> createState() => _HideContactScreenState();
}

class _HideContactScreenState extends State<HideContactScreen> {
  AddContactProvider? providerW;
  AddContactProvider? providerR;
  @override
  Widget build(BuildContext context) {
    providerW = context.watch<AddContactProvider>();
    providerR = context.read<AddContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hide Contact" ,style: TextStyle(fontSize: 20),),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: providerW!.hideContactList.length,
          itemExtent: 100,
          itemBuilder: (context, index) {
            return Consumer(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    providerR!.isLock = true;
                    providerR!.storeIndex(index);
                    Navigator.pushNamed(context, 'update',
                        arguments: providerR!.hideContactList[index]);
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
                                    providerW!.hideContactList[index].image != null
                                        ? CircleAvatar(
                                      radius: 25,
                                      backgroundImage: FileImage(File(
                                          "${providerW!.hideContactList[index].image}")),
                                    )
                                        : Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black),
                                      child: Text(
                                        "${providerW!.hideContactList[index].fName!.isNotEmpty ? providerW!.hideContactList[index].fName?.substring(0, 1).toUpperCase() : 0}",
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
                                  "${providerW!.hideContactList[index].fName}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${providerW!.hideContactList[index].phone}",
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
      ),
    );
  }
}
