import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/contect_model.dart';
import '../provider/add_contact_provider.dart';

void updateWidget(BuildContext context, ContactModel c1) {
  TextEditingController txtfName = TextEditingController(text: c1.fName);
  TextEditingController txtPhone = TextEditingController(text: c1.phone);
  TextEditingController txtEmail = TextEditingController(text: c1.email);
  AddContactProvider? providerR;
  providerR = context.read<AddContactProvider>();
  showDialog(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Edit Contact'),
          actions: [
            InkWell(
              onTap: () async {
                ImagePicker picker = ImagePicker();
                XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
                providerR!.uploadImage(image!.path);
              },
              child: Align(
                alignment: Alignment.center,
                child: c1.image != null || providerR!.path != null
                    ? CircleAvatar(
                  radius: 70,
                  child: Text("${c1.fName?.substring(0, 1).toUpperCase()}",
                      style: const TextStyle(fontSize: 20)),
                )
                    : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                    File(
                        "${c1.image}"),
                  ),
                ),
              ),
            ),
            TextField(
              controller: txtfName,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Name'),
            ),
            TextField(
              controller: txtPhone,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Contact'),
            ),
            TextField(
              controller: txtEmail,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                ContactModel cm = ContactModel(
                    image: c1.image,
                    email: txtEmail.text,
                    phone: txtPhone.text,
                    fName: txtfName.text);
                context.read<AddContactProvider>().editContact(cm);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Align(
                  alignment: Alignment.center, child: Text('Update')),
            ),
          ],
        ),
      );
    },
  );
}
