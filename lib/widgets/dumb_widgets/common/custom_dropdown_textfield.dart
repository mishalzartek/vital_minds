import 'package:flutter/material.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/smart_widgets/journal/journal_view_model.dart';

class CustomDropdownTextField extends StatefulWidget {
  final JournalViewModel viewModel;
  final int index;

  const CustomDropdownTextField({Key key, this.viewModel, this.index})
      : super(key: key);
  @override
  _CustomDropdownTextFieldState createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  final FocusNode _focusNode = FocusNode();
  GlobalKey _customDropdownTextField;
  Offset textFieldPosition;
  Size textFieldSize;
  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  List<String> gratefulOptions = [
    'This helped me get through the day',
    'I have extra appreciation for',
    'I realized the importance of',
    "I'm simply grateful for",
    "Someone I should thank",
    "I consider myself lucky because"
  ];

  @override
  void initState() {
    super.initState();
    _customDropdownTextField = LabeledGlobalKey("button_icon");
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        openMenu();
      } else {
        closeMenu();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return CompositedTransformTarget(
        link: this._layerLink,
        child: TextFormField(
          key: _customDropdownTextField,
          focusNode: _focusNode,
          textCapitalization: TextCapitalization.sentences,
          controller: widget.viewModel.gratefulForControllers[widget.index],
          maxLines: null,
          onChanged: (value) {
            findTextField();
          },
          onSaved: (value) => widget.viewModel.cancelNotification(),
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          decoration: InputDecoration(
            hintText: 'What are you thankful for today?',
            contentPadding:
                EdgeInsets.only(top: 0.01 * height, bottom: 0.01 * height),
            isDense: true,
            hintStyle: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ));
  }

  findTextField() {
    RenderBox renderBox =
        _customDropdownTextField.currentContext.findRenderObject() as RenderBox;
    textFieldSize = renderBox.size;
    textFieldPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
  }

  void openMenu() {
    findTextField();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        height: 200,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, textFieldSize.height + 5.0),
          child: Material(
            elevation: 4.0,
            color: Themes.color.withAlpha(230),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: List.generate(
                gratefulOptions.length,
                (index) => Column(
                  children: [
                    Divider(
                      height: 0,
                      color: Colors.white54,
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          gratefulOptions[index] + '...',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        widget.viewModel.gratefulForControllers[widget.index]
                            .text = gratefulOptions[index] + ' ';
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
