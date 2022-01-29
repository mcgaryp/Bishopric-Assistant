import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:crypt/crypt.dart';
import 'package:models/models/account.dart';

///
/// EditProfile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/18/21
/// Copyright 2021 Po. All rights reserved.
///

class EditProfile extends StatefulWidget {
  final void Function() onSave;

  const EditProfile(this.onSave, {Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();

  bool _isWaiting = false;
  bool _changeWasMade = false;

  late Account account;

  @override
  void dispose() {
    super.dispose();
    passwordControl.dispose();
    confirmPasswordControl.dispose();
    emailControl.dispose();
    phoneControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    account = StateContainer.of(context).account;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AbsorbPointer(
            absorbing: _isWaiting,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField.floating(
                    account.contact.email,
                    controller: emailControl,
                    validator: (str) =>
                        Validators.validateEmail(str, isUpdating: true),
                    onSubmit: _onSave,
                  ),
                  InputField.floating(
                    account.contact.phone,
                    controller: phoneControl,
                    validator: (str) =>
                        Validators.standard(str, isUpdating: true),
                    errorColorIsDark: true,
                    formattingList: [Validators.phoneFilter],
                    onSubmit: _onSave,
                  ),
                  InputField.floating(
                    sPassword,
                    isPassword: true,
                    controller: passwordControl,
                    validator: (str) =>
                        Validators.validatePassword(str, isUpdating: true),
                    onSubmit: _onSave,
                    //errorMsg: _errorMsg
                  ),
                  InputField.floating(
                    sConfirmPassword,
                    isPassword: true,
                    controller: confirmPasswordControl,
                    validator: (text) => Validators.validateConfirmPassword(
                        text, passwordControl.text,
                        isUpdating: true),
                    //errorMsg: _errorMsg,
                    onSubmit: _onSave,
                  ), //add
                  MyButton(label: sSave, onPressed: _onPress),
                  Padding(
                    padding: const EdgeInsets.only(top: padding16),
                    child: MyButton(
                      label: sCancel,
                      onPressed: widget.onSave,
                      style: MyButtonStyle.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }

  void _onSave(String? str) => _onPress();

  Future _onPress() async {
    _setIsWaiting(true);

    // Verify information in form
    if (_formKey.currentState!.validate()) {
      try {
        if (passwordControl.text.isNotEmpty) await _changePassword();
        if (emailControl.text.isNotEmpty || phoneControl.text.isNotEmpty)
          await _changeContact();

        if (_changeWasMade) {
          FirebaseAccountRepository repo = FirebaseAccountRepository();
          Account? updatedAccount = await repo.find(account.id);
          if (updatedAccount != null)
            StateContainer.of(context).updateAccount(updatedAccount);
          widget.onSave();
        }
      } catch (e) {
        MyToast.toastError(e.toString());
        if (kDebugMode) print(e.toString());
      }
    }

    // Turn off the spinner
    _setIsWaiting(false);
  }

  Future<void> _changePassword() async {
    String hashPassword =
        Crypt.sha256(passwordControl.text, salt: "bishopric").toString();
    // Get encrypted Password from database
    FirebaseAccountRepository _accountRepository = FirebaseAccountRepository();
    DefaultChangePasswordUseCase newPassword =
        DefaultChangePasswordUseCase(_accountRepository);

    if (await newPassword.execute(
        accountID: account.id, password: hashPassword)) {
      MyToast.toastSuccess("Password Updated Successfully");
      _setChangeWasMade(true);
    }
  }

  void _setIsWaiting(bool val) => setState(() => _isWaiting = val);

  void _setChangeWasMade(bool val) => setState(() => _changeWasMade = val);

  Future<void> _changeContact() async {
    DefaultChangeContactUseCase useCase =
        DefaultChangeContactUseCase(FirebaseAccountRepository());
    String email = account.contact.email;
    String feedbackStr = "";
    if (emailControl.text.isNotEmpty) {
      email = emailControl.text;
      feedbackStr += "User email successfully changed to '$email'";
    }
    String phone = account.contact.phone;
    if (phoneControl.text.isNotEmpty) {
      phone = phoneControl.text;
      feedbackStr += "\nPhone number successfully changed to '$phone'";
    }

    Contact contact = Contact(email: email, phone: phone);

    if (await useCase.execute(accountID: account.id, contact: contact)) {
      MyToast.toastSuccess(feedbackStr);
      _setChangeWasMade(true);
    }
  }
}
