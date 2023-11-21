import 'dart:io';

import 'package:calculater_app/model/contect_model.dart';
import 'package:calculater_app/provider/add_contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {

  AddContactProvider? providerW;
  AddContactProvider? providerR;
  TextEditingController txtFName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> contactKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    providerW = context.watch<AddContactProvider>();
    providerR = context.read<AddContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Contact"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stepper(
                currentStep: providerW!.stepIndex,
                onStepContinue: () {
                  if(providerW!.stepIndex == 1 )
                  {
                    if(nameKey.currentState!.validate())
                      {
                        providerW!.nextStep();
                      }
                  }
                  else if(providerW!.stepIndex == 2)
                  {
                    if(contactKey.currentState!.validate())
                      {
                        providerW!.nextStep();
                      }
                  }
                  else
                    {
                      providerW!.nextStep();
                    }
                },
                onStepCancel: () {
                  providerW!.cancelStep();
                },
                steps: [
                  Step(
                    title: const Text("Image"),
                    content: Column(
                      children: [
                        Consumer<AddContactProvider>(
                          builder: (context, value, child) => CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: value.path != null ? FileImage(File(value.path!)):null,
                            maxRadius: 60,
                            minRadius: 60,
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              providerR!.uploadImage(image!.path);
                            },
                            icon: const Icon(Icons.camera_alt)),
                      ],
                    ),
                  ),
                  Step(
                      title: const Text("First Name"),
                      content: Form(
                        key: nameKey,
                        child: TextFormField(
                          validator: (value)
                          {
                            if(value == null || value.isEmpty)
                              {
                                return 'Enter your name Complaisant';
                              }
                            return null;
                          },
                          controller: txtFName,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(
                                "Name",
                              )),
                        ),
                      )),
                  Step(
                      title: const Text("Phone"),
                      content: Form(
                        key: contactKey,
                        child: TextFormField(
                          validator: (value) {
                            if(value == null || value.isEmpty)
                            {
                              return 'Enter your number';
                            }
                            return null;
                          },
                          controller: txtPhone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), label: Text("Phone")),
                        ),
                      )),
                  Step(
                    title: const Text("Email"),
                    content: TextFormField(
                      controller: txtEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text("Email")),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  ContactModel cm = ContactModel(
                      email: txtEmail.text,
                      fName: txtFName.text,
                      phone: txtPhone.text,
                    image: providerR!.path,
                  );
                  providerR!.addContactData(cm);
                  Navigator.pop(context);
                  providerR!.clean();
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
