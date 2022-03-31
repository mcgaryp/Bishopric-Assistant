import 'package:bishop_assistant_web_test_app/pages/organization/join_request_detail_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/edit_member_details_card.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/account.dart';
import 'package:models/models/assignment.dart';
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
        // Large Title
        Center(child: Text("largeTitle", style: largeTitle)),
        Text("largeTitleDark", style: largeTitleDark),
        Text("largeTitleLight", style: largeTitleLight),
        // Title
        Text("title", style: title),
        Text("titleDark", style: titleDark),
        Text("titleLight", style: titleLight),
        // Small Title
        Text("smallTitle", style: smallTitle),
        Text("smallTitleDark", style: smallTitleDark),
        Text("smallTitleLight", style: smallTitleLight),
        // Headline
        Text("headline", style: headline),
        Text("headlineDark", style: headlineDark),
        Text("headlineLight", style: headlineLight),
        // SubHeadline
        Text("subHeadline", style: subhead),
        Text("subHeadlineDark", style: subheadDark),
        Text("subHeadlineLight", style: subheadLight),
        // Body
        Text("body", style: body),
        Text("bodyDark", style: bodyDark),
        Text("bodyLight", style: bodyLight),
        Text("bodyRed", style: bodyRed),
        // Callout
        Text("callout", style: callout),
        Text("calloutDark", style: calloutDark),
        Text("calloutLight", style: calloutLight),
        // Caption
        Text("captionDark", style: caption),
        Text("captionDark", style: captionDark),
        Text("captionLight", style: captionLight),
        Text("captionRed", style: captionRed),
        // Footnote
        Text("footnote", style: footnote),
        Text("footnoteDark", style: footnoteDark),
        Text("footnoteLight", style: footnoteLight),
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
        _ColorBox(green, "green"),
        _ColorBox(warning, "warning"),
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
        _DecorationBox(floatingDarkBox, "floatingDarkBox", style: calloutLight),
        _DecorationBox(floatingWarningBox, "floatingWarningBox"),
        _DecorationBox(floatingErrorRedBox, "floatingErrorRedBox",
            style: calloutLight),
      ]),
      Section(title: "Buttons", children: [
        Text("Expanded", style: subhead),
        _AButton(MyButtonStyle.text),
        _AButton(MyButtonStyle.darkText),
        _AButton(MyButtonStyle.lightText),
        _AButton(MyButtonStyle.errorText),
        _AButton(MyButtonStyle.smallText),
        _AButton(MyButtonStyle.floating),
        _AButton(MyButtonStyle.floatingError),
        Text("Not Expanded", style: subhead),
        MyButton.icon(
            icon: Icon(Icons.group), onPressed: () => _onPressed(context)),
        _AButton(MyButtonStyle.text, isExpanded: false),
        _AButton(MyButtonStyle.darkText, isExpanded: false),
        _AButton(MyButtonStyle.lightText, isExpanded: false),
        _AButton(MyButtonStyle.errorText, isExpanded: false),
        _AButton(MyButtonStyle.smallText, isExpanded: false),
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
          RowToggle("Row Toggle", onChanged: (bool) {}, value: true),
          SearchBar(
              onChange: (Result<List> list) {},
              filter: (any, String? str) => throw UnimplementedError(),
              searchableItems: [])
        ]),
      ),
      Section(title: "Animations", children: [
        _Animation(
            label: "SpinKitThreeBounce size: 25",
            spinner: SpinKitThreeBounce(color: dark, size: 25)),
        _Animation(label: "SpinKitCircle", spinner: SpinKitCircle(color: dark)),
        _Animation(label: "SpinKitPulse", spinner: SpinKitPulse(color: dark)),
        _Animation(
            label: "SpinKitDoubleBounce",
            spinner: SpinKitDoubleBounce(color: dark)),
        _Animation(
            label: "SpinKitChasingDots",
            spinner: SpinKitChasingDots(color: dark, size: 35)),
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
              _ExampleCard(),
              MyDrawerHeader(account),
              OrganizationCard(organization: organization),
              JoinRequestDetailsView(
                JoinRequestDetail(
                    name: Name(first: "Test", last: "Join Request"),
                    request: JoinRequest(
                        accountID: AccountID("Fake"),
                        organizationID: OrganizationID("Also Fake"))),
                onChange: (request) {},
              ),
              MemberTitle(member),
              MemberDetailsCard(member),
              EditMemberDetailsCard(member),
              ArchivedAssignmentCard(archivedAssignment),
              DefaultAssignmentCard(assignment, () {}),
              EditAssignmentCard(assignment, () {}),
              CreateAssignmentCard(),
            ],
          ),
        ),
      ]),
      Section(title: "Additional Widgets", children: [
        MyCalendar(List.filled(2, AssignmentCalendarEvent(assignment))),
      ]),
    ]));
  }

  Member get member => Mocks().mockMember;

  Organization get organization => Mocks().mockOrganization;

  Account get account => Mocks().mockAccount;

  Assignment get assignment {
    Assignment assignment = Mocks().mockAssignment;
    if (assignment.isArchived) assignment.unArchive();
    return assignment;
  }

  Assignment get archivedAssignment {
    Assignment assignment = Mocks().mockAssignment;
    if (assignment.isNotArchived) assignment.archive();
    return assignment;
  }
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

  const _ColorBox(this.color, this.str, {this.style = callout, Key? key})
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
      {this.style = callout, Key? key})
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

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(children: [
      CardTitle("Card Title"),
      CardSubtitle(DateTime.now()),
      CardColumn("Card Column",
          content: "Some information in the content area of the column"),
      CardRow("Card Row",
          content: "Some contents in the content area of the row"
              " that have a tendency to be very long information sometimes"),
      CardDateTimeRow((DateTime time) {}),
      CardTextFieldRow("Card Text Field Row"),
    ]));
  }
}

class _Animation extends StatelessWidget {
  final String label;
  final Widget spinner;

  const _Animation({Key? key, required this.label, required this.spinner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Flexible(child: Text(label, style: body, maxLines: null)),
      spinner,
    ]);
  }
}
