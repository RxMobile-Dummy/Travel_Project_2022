import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';

class FaqPage extends StatefulWidget {
  FaqPage({Key? key}) : super(key: key);

  @override
  _HtmlEditorExampleState createState() => _HtmlEditorExampleState();
}

class _HtmlEditorExampleState extends State<FaqPage> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.getText().then((value) => print("testtttt $value"));
              controller.toggleCodeView();
            },
            child: const Text(r'<\>',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Add New FAQ',
                    style: AppTextStyles.labelStyle
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Title Here',
                          hintStyle: AppTextStyles.unselectedLabelStyle
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MakeMyTripColors.colorBlack),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: HtmlEditor(
                        controller: controller,
                        htmlEditorOptions: const HtmlEditorOptions(
                          hint: 'Your text here...',
                          shouldEnsureVisible: true,
                          //initialText: "<p>text content initial, if any</p>",
                        ),
                        htmlToolbarOptions: HtmlToolbarOptions(
                          toolbarPosition:
                              ToolbarPosition.aboveEditor, //by default
                          toolbarType:
                              ToolbarType.nativeScrollable, //by default
                          onButtonPressed: (ButtonType type, bool? status,
                              Function? updateStatus) {
                            print(
                                "button '${describeEnum(type)}' pressed, the current selected status is $status");
                            return true;
                          },
                          onDropdownChanged: (DropdownType type,
                              dynamic changed,
                              Function(dynamic)? updateSelectedItem) {
                            print(
                                "dropdown '${describeEnum(type)}' changed to $changed");
                            return true;
                          },
                          mediaLinkInsertInterceptor:
                              (String url, InsertFileType type) {
                            print(url);
                            return true;
                          },
                          mediaUploadInterceptor:
                              (PlatformFile file, InsertFileType type) async {
                            print(file.name); //filename
                            print(file.size); //size in bytes
                            print(file
                                .extension); //file extension (eg jpeg or mp4)
                            return true;
                          },
                        ),
                        otherOptions: const OtherOptions(height: 550),
                        callbacks: Callbacks(
                            onBeforeCommand: (String? currentHtml) {
                          print('html before change is $currentHtml');
                        }, onChangeContent: (String? changed) {
                          print('content changed to $changed');
                        }, onChangeCodeview: (String? changed) {
                          print('code changed to $changed');
                        }, onChangeSelection: (EditorSettings settings) {
                          print('parent element is ${settings.parentElement}');
                          print('font name is ${settings.fontName}');
                        }, onDialogShown: () {
                          print('dialog shown');
                        }, onEnter: () {
                          print('enter/return pressed');
                        }, onFocus: () {
                          print('editor focused');
                        }, onBlur: () {
                          print('editor unfocused');
                        }, onBlurCodeview: () {
                          print('codeview either focused or unfocused');
                        }, onInit: () {
                          print('init');
                        },
                            //this is commented because it overrides the default Summernote handlers
                            /*onImageLinkInsert: (String? url) {
                            print(url ?? "unknown url");
                          },
                          onImageUpload: (FileUpload file) async {
                            print(file.name);
                            print(file.size);
                            print(file.type);
                            print(file.base64);
                          },*/
                            onImageUploadError: (FileUpload? file,
                                String? base64Str, UploadError error) {
                          print(describeEnum(error));
                          print(base64Str ?? '');
                          if (file != null) {
                            print(file.name);
                            print(file.size);
                            print(file.type);
                          }
                        }, onKeyDown: (int? keyCode) {
                          print('$keyCode key downed');
                          print(
                              'current character count: ${controller.characterCount}');
                        }, onKeyUp: (int? keyCode) {
                          print('$keyCode key released');
                        }, onMouseDown: () {
                          print('mouse downed');
                        }, onMouseUp: () {
                          print('mouse released');
                        }, onNavigationRequestMobile: (String url) {
                          print(url);
                          return NavigationActionPolicy.ALLOW;
                        }, onPaste: () {
                          print('pasted into editor');
                        }, onScroll: () {
                          print('editor scrolled');
                        }),
                        plugins: [
                          SummernoteAtMention(
                              getSuggestionsMobile: (String value) {
                                var mentions = <String>[
                                  'test1',
                                  'test2',
                                  'test3'
                                ];
                                return mentions
                                    .where((element) => element.contains(value))
                                    .toList();
                              },
                              mentionsWeb: ['test1', 'test2', 'test3'],
                              onSelect: (String value) {
                                print(value);
                              }),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.color70gray),
                          onPressed: () {
                            controller.undo();
                          },
                          child: Text('Undo',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.color70gray),
                          onPressed: () {
                            controller.clear();
                          },
                          child: Text('Reset',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () async {
                            var txt = await controller.getText();
                            if (txt.contains('src=\"data:')) {
                              txt =
                                  '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                            }
                            setState(() {
                              result = txt;
                            });
                          },
                          child: Text(
                            'Submit',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () {
                            controller.redo();
                          },
                          child: Text(
                            'Redo',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(result),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.color70gray),
                          onPressed: () {
                            controller.disable();
                          },
                          child: Text('Disable',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () async {
                            controller.enable();
                          },
                          child: Text(
                            'Enable',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () {
                            controller.insertText('Google');
                          },
                          child: Text('Insert Text',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () {
                            controller.insertHtml(
                                '''<p style="color: blue">Google in blue</p>''');
                          },
                          child: Text('Insert HTML',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () async {
                            controller.insertLink(
                                'Google linked', 'https://google.com', true);
                          },
                          child: Text(
                            'Insert Link',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () {
                            controller.insertNetworkImage(
                                'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png',
                                filename: 'Google network image');
                          },
                          child: Text(
                            'Insert network image',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.color70gray),
                          onPressed: () {
                            controller.addNotification(
                                'Info notification', NotificationType.info);
                          },
                          child: Text('Info',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.color70gray),
                          onPressed: () {
                            controller.addNotification('Warning notification',
                                NotificationType.warning);
                          },
                          child: Text('Warning',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () async {
                            controller.addNotification('Success notification',
                                NotificationType.success);
                          },
                          child: Text(
                            'Success',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () {
                            controller.addNotification(
                                'Danger notification', NotificationType.danger);
                          },
                          child: Text(
                            'Danger',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.color70gray),
                          onPressed: () {
                            controller.addNotification('Plaintext notification',
                                NotificationType.plaintext);
                          },
                          child: Text('Plaintext',
                              style: AppTextStyles.infoContentStyle5.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 14)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: MakeMyTripColors.accentColor),
                          onPressed: () async {
                            controller.removeNotification();
                          },
                          child: Text(
                            'Remove',
                            style: AppTextStyles.infoContentStyle5.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
