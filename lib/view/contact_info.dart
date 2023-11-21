import 'dart:io';

import 'package:calculater_app/model/contect_model.dart';
import 'package:calculater_app/provider/add_contact_provider.dart';
import 'package:calculater_app/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  AddContactProvider? providerW;
  AddContactProvider? providerR;

  @override
  Widget build(BuildContext context) {
    providerW = context.watch<AddContactProvider>();
    providerR = context.read<AddContactProvider>();
    ContactModel c1 =
        ModalRoute.of(context)!.settings.arguments as ContactModel;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {
                  providerR!.shareData(c1);
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    c1.image == null
                        ? CircleAvatar(
                            radius: 60,
                            child: Text(
                              "${c1.fName?.substring(0, 1).toUpperCase()}",
                              style: const TextStyle(fontSize: 60),
                            ),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File("${c1.image}")),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          providerR!.uploadImage(image!.path);
                        },
                        icon: const Icon(Icons.camera_alt)),
                    Text(
                      "${c1.fName}",
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                Uri uri = Uri.parse("tel: +91 ${c1.phone}");
                                await launchUrl(uri);
                              },
                              icon: const Icon(
                                Icons.call,
                                color: Colors.green,
                              )),
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                Uri uri = Uri.parse("sms: ${c1.phone}");
                                await launchUrl(uri);
                              },
                              icon: const Icon(
                                Icons.message,
                                color: Colors.amber,
                              )),
                          const Spacer(),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.video_call)),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "Call",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Text(
                            "Text",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Text(
                            "Video",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Contact info",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black38),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      Uri uri = Uri.parse("tel: +91 ${c1.phone}");
                                      await launchUrl(uri);
                                    },
                                    icon: const Icon(
                                      Icons.call,
                                      size: 33,
                                      color: Colors.green,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "+91 ${c1.phone}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const Text(
                                      "Mobile",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.video_call)),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.message)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      Uri uri = Uri.parse("sms: ${c1.phone}");
                                      await launchUrl(uri);
                                    },
                                    icon: const Icon(
                                      Icons.message,
                                      size: 32,
                                      color: Colors.amber,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Message",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "+91 ${c1.phone}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.call,
                                      size: 33,
                                      color: Colors.black,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Voice Call",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "+91 ${c1.phone}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.video_call,
                                      size: 38,
                                      color: Colors.green,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Video call",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "+91 ${c1.phone}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      Uri uri = Uri.parse("mailto: ${c1.email}");
                                      await launchUrl(uri);
                                    },
                                    icon: const Icon(
                                      Icons.email,
                                      size: 38,
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Email",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${c1.email}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              providerR!.deleteContactData();
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              updateWidget(context, c1);
                            },
                            icon: const Icon(
                              Icons.update,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if(providerR!.isLock == true)
                                {
                                  providerR!.unHideContact();
                                }
                              else
                                {
                                  providerR!.hideContact();
                                }
                              Navigator.pop(context);
                            },
                            icon: providerR!.isLock ? const Icon(
                              Icons.visibility,
                              size: 30,
                            ) : const Icon(Icons.visibility_off,size: 30,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
