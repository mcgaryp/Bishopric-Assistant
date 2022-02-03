import 'package:bishop_assistant_web_test_app/pages/organization/join_request_detail_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// theme_page.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage(
        child: ListView(children: [
      Section(title: 'Topography', children: [
        Center(child: Text("Large Title", style: largeTitle)),
        Text("Title Light", style: titleLight),
        Text("Title Dark", style: titleDark),
        Text("Small Title Light", style: smallTitleLight),
        Text("Small Title Dark", style: smallTitleDark),
        Text("Headline Light", style: headlineLight),
        Text("Headline Dark", style: headlineDark),
        Text("SubHeadline Light", style: subheadLight),
        Text("SubHeadline Dark", style: subheadDark),
        Text("Body Light", style: bodyLight),
        Text("Body Dark", style: bodyDark),
        Text("Body Red", style: bodyRed),
        Text("Callout Light", style: calloutLight),
        Text("Callout Dark", style: calloutDark),
        Text("Caption Light", style: captionLight),
        Text("Caption Dark", style: captionDark),
        Text("Footnote Light", style: footnoteLight),
        Text("Footnote Dark", style: footnoteDark),
      ]),
      Section(title: "Colors", children: [
        _ColorBox(light, "light"),
        _ColorBox(lightGrey, "lightGrey"),
        _ColorBox(dark, "dark", style: calloutLight),
        _ColorBox(shadow, "shadow"),
        _ColorBox(lightPrimary, "lightPrimary"),
        _ColorBox(darkPrimary, "darkPrimary", style: calloutLight),
        _ColorBox(lightSecondary, "lightSecondary"),
        _ColorBox(darkSecondary, "darkSecondary"),
        _ColorBox(errorRed, "errorRed", style: calloutLight),
        _ColorBox(darkText, "darkText", style: calloutLight),
        _ColorBox(lightText, "lightText"),
      ]),
      Section(title: "Decoration", children: [
        _DecorationBox(floatingLightBox, "floatingLightBox"),
        _DecorationBox(
          floatingLightPrimaryBox,
          "floatingLightPrimaryBox",
          style: calloutLight,
        ),
        _DecorationBox(
          floatingDarkPrimaryHalfBorderBox,
          "floatingDarkPrimaryHalfBorderBox",
          style: calloutLight,
        ),
        _DecorationBox(darkPrimaryBox, "darkPrimaryBox", style: calloutLight),
        _DecorationBox(lightBox, "lightBox"),
        _DecorationBox(invisibleBox, "invisibleBox"),
        _DecorationBox(darkBorderBox, "darkBorderBox"),
        _DecorationBox(errorRedBorderBox, "errorRedBorderBox"),
        _DecorationBox(floatingDarkCircleBox, "floatingDarkCircleBox"),
      ]),
      Section(title: "Buttons", children: [
        Text("Expanded", style: subheadDark),
        _AButton(MyButtonStyle.text),
        _AButton(MyButtonStyle.lightText),
        _AButton(MyButtonStyle.errorText),
        _AButton(MyButtonStyle.darkText),
        _AButton(MyButtonStyle.floating),
        _AButton(MyButtonStyle.floatingError),
        Text("Not Expanded", style: subheadDark),
        MyButton.icon(
            icon: Icon(Icons.group), onPressed: () => _onPressed(context)),
        _AButton(MyButtonStyle.text, isExpanded: false),
        _AButton(MyButtonStyle.lightText, isExpanded: false),
        _AButton(MyButtonStyle.errorText, isExpanded: false),
        _AButton(MyButtonStyle.darkText, isExpanded: false),
        _AButton(MyButtonStyle.floating, isExpanded: false),
        _AButton(MyButtonStyle.floatingError, isExpanded: false),
      ]),
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Section(title: "Input Boxes", children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InputField.border("border"),
          ),
          InputField.floating("floating"),
          InputField.plain("plain"),
          MyDropdown(hint: "MyDropdown"),
          MyDropdown(hint: "MyDropDown, isInput: false", isInput: false),
          RowToggle("Row Toggle"),
          SearchBar(
              onChange: (Result<List> list) {},
              filter: (any, String? str) => throw UnimplementedError(),
              searchableItems: [])
        ]),
      ),
      Section(title: "Animations", children: [
        SpinKitThreeBounce(color: dark, size: 25),
        SpinKitCircle(color: dark),
        SpinKitPulse(color: dark),
        SpinKitDoubleBounce(color: dark),
        SpinKitChasingDots(color: dark, size: 35),
      ]),
      Section(title: "Dialogs", children: [
        ConfirmationDialog(
            onConfirm: () {},
            title: "Confirmation Dialog",
            content: "Are you sure you want to press that button?"),
      ]),
      Section(title: "Cards", children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MemberDetailsCard(member),
              JoinRequestDetailsView(JoinRequestDetail(
                  name: Name(first: "Test", last: "Join Request"),
                  request: JoinRequest(
                      accountID: AccountID("Fake"),
                      organizationID: OrganizationID("Also Fake")))),
              MemberTitle(member),
              OrganizationCard(organization: organization),
              MyDrawerHeader(account),
              MyCard(
                  child: Column(children: [
                CardTitle("Card Title"),
                CardSubtitle(DateTime.now()),
                CardColumn("Card Column",
                    content:
                        "Some information in the content area of the column"),
                CardRow("Card Row",
                    content: "Some contents in the content area of the row"
                        " that have a tendency to be very long information sometimes"),
                CardDateTimeRow((DateTime time) {}),
                CardTextFieldRow("Card Text Field Row"),
              ]))
            ],
          ),
        ),
      ]),
    ]));
  }

  Name get name => Name(first: "Fake", last: "Member");

  Contact get contact =>
      Contact(email: "fake@email.com", phone: "(123) 456-7890");

  Member get member => Member(
      id: MemberID("fakeID"),
      name: name,
      contact: contact,
      role: Role(Permissions.Maintainer, anonymous: "Fake Member Role"));

  Organization get organization => Organization(
      id: OrganizationID("Fake Org ID"),
      name: "The Fake Organization",
      creator: member);

  Account get account => Account(
      name: name,
      contact: contact,
      credentials:
          Credentials(password: "fakePassword1", username: "fakeUsername"));
}

class _AButton extends StatelessWidget {
  final MyButtonStyle style;
  final bool isExpanded;

  const _AButton(this.style, {this.isExpanded = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
        label: style.name,
        onPressed: () => _onPressed(context),
        style: style,
        isExpanded: isExpanded);
  }
}

void _onPressed(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext con) => ConfirmationDialog(
          onConfirm: () => _pop(con),
          title: "Confirmation Dialog",
          content: "Are you sure that you want to press this button?"));
}

void _pop(BuildContext context) => Navigator.pop(context);

class _ColorBox extends StatelessWidget {
  final Color color;
  final String str;
  final TextStyle style;

  const _ColorBox(this.color, this.str, {this.style = calloutDark, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: color,
      child: Center(child: Text(str, style: style)),
    );
  }
}

class _DecorationBox extends StatelessWidget {
  final String str;
  final BoxDecoration decoration;
  final TextStyle style;

  const _DecorationBox(this.decoration, this.str,
      {this.style = calloutDark, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(str, style: style),
          ),
        ),
      ),
    );
  }
}
