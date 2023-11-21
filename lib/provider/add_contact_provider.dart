import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:share_plus/share_plus.dart';

import '../model/contect_model.dart';

class AddContactProvider with ChangeNotifier {

  int stepIndex = 0;
  String? path;
  bool isPrivate = false;
  bool isLock = false;
  int? infoIndex;

  List<ContactModel> addDataList = [];
  List<ContactModel> hideContactList = [];

  void setStepIndex(int index) {
    stepIndex = index;
    notifyListeners();
  }

  void nextStep() {
    if (stepIndex < 3)
    {
      stepIndex++;
    }
    notifyListeners();
  }

  void cancelStep() {
    if (stepIndex > 0)
    {
      stepIndex--;
    }
    notifyListeners();
  }

  void uploadImage(String? newPath) {
    path = newPath;
    notifyListeners();
  }

  void addContactData(ContactModel cm) {
    addDataList.add(cm);
    notifyListeners();
  }

  void clean() {
    stepIndex = 0 ;
    notifyListeners();
  }

  void storeIndex(int index) {
    infoIndex = index;
    notifyListeners();
  }

  Future<void> shareData(ContactModel c1) async {
    Share.share("${c1.fName} \n ${c1.phone}");
    ShareResult result = await Share.shareWithResult("");
  }

  void deleteContactData () {
    if(isLock)
      {
        hideContactList.removeAt(infoIndex!);
      }
    else
      {
        addDataList.removeAt(infoIndex!);
      }
    notifyListeners();
  }

  void editContact(ContactModel c1) {
    if (isLock)
    {
      hideContactList[infoIndex!] = c1;
    }
    else
    {
      addDataList[infoIndex!] = c1;
    }
    notifyListeners();
  }

  void hideContact() {
    ContactModel hiddenContact = addDataList[infoIndex!];
    hideContactList.add(hiddenContact);
    addDataList.removeAt(infoIndex!);
    notifyListeners();
  }

  void unHideContact() {
    ContactModel unHiddenContact = hideContactList[infoIndex!];
    addDataList.add(unHiddenContact);
    hideContactList.removeAt(infoIndex!);
    notifyListeners();
  }

  Future<bool?> bioMatrix() async {
    LocalAuthentication auth = LocalAuthentication();
    bool checkBioMatrixStatus = await auth.canCheckBiometrics;
    if (checkBioMatrixStatus) {
      List<BiometricType> bioTypes = await auth.getAvailableBiometrics();
      if (bioTypes.isNotEmpty) {
        bool isLogin = await auth.authenticate(
          localizedReason: 'Please Correct privacy Password',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        return isLogin;
      }
    }
    return null;
  }
}



