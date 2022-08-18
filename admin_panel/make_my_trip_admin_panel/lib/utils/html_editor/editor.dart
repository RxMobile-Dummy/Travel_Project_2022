import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../../core/theme/make_my_trip_colors.dart';
import '../../core/theme/text_styles.dart';
import 'content_model.dart';

typedef void StringCallback(String val);

class EditorPage extends StatefulWidget {
  EditorPage({Key? key, required this.contentModel, required this.callback})
      : super(key: key);

  final HtmlEditorController controller = HtmlEditorController();
  List<ContentModel> contentModel;
  final StringCallback callback;

  @override
  _HtmlEditorExampleState createState() => _HtmlEditorExampleState();
}

class _HtmlEditorExampleState extends State<EditorPage> {
  String result = '';
  String data = '';
  @override
  void initState() {
    super.initState();
    if (widget.contentModel.isNotEmpty) {
      result = widget.contentModel[0].title ?? "";
    }
    Future.delayed(Duration(seconds: 5)).then((value) {
      try {
        if (widget.contentModel.isNotEmpty) {
          widget.controller.insertHtml(widget.contentModel[0].title ?? "");
        }
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          widget.controller.clearFocus();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: MakeMyTripColors.colorBlack),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: HtmlEditor(
                controller: widget.controller,
                htmlEditorOptions: HtmlEditorOptions(
                  initialText: result,
                  hint: StringConstants.editorHint,
                  shouldEnsureVisible: true,
                  //initialText: "<p>text content initial, if any</p>",
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.aboveEditor, //by default
                  toolbarType: ToolbarType.nativeScrollable, //by default
                  onButtonPressed:
                      (ButtonType type, bool? status, Function? updateStatus) {
                    if (kDebugMode) {
                      print(
                          "button '${describeEnum(type)}' pressed, the current selected status is $status");
                    }
                    return true;
                  },
                  onDropdownChanged: (DropdownType type, dynamic changed,
                      Function(dynamic)? updateSelectedItem) {
                    if (kDebugMode) {
                      print(
                          "dropdown '${describeEnum(type)}' changed to $changed");
                    }
                    return true;
                  },
                  mediaLinkInsertInterceptor:
                      (String url, InsertFileType type) {
                    debugPrint(url);
                    return true;
                  },
                  mediaUploadInterceptor:
                      (PlatformFile file, InsertFileType type) async {
                    if (kDebugMode) {
                      print(file.name);
                      print(file.size);
                      print(file.extension);
                    } //filename
                    return true;
                  },
                ),
                otherOptions: const OtherOptions(height: 550),
                callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
                  if (kDebugMode) {
                    print('html before change is $currentHtml');
                  }
                }, onChangeContent: (String? changed) {
                  if (kDebugMode) {
                    print('content changed to $changed');
                  }
                  data = changed ?? "";
                }, onChangeCodeview: (String? changed) {
                  if (kDebugMode) {
                    print('code changed to $changed');
                  }
                }, onChangeSelection: (EditorSettings settings) {
                  if (kDebugMode) {
                    print('parent element is ${settings.parentElement}');
                    print('font name is ${settings.fontName}');
                  }
                }, onDialogShown: () {
                  if (kDebugMode) {
                    print('dialog shown');
                  }
                }, onEnter: () {
                  if (kDebugMode) {
                    print('enter/return pressed');
                  }
                }, onFocus: () {
                  if (kDebugMode) {
                    print('editor focused');
                  }
                }, onBlur: () {
                  if (kDebugMode) {
                    print('editor unfocused');
                  }
                }, onBlurCodeview: () {
                  if (kDebugMode) {
                    print('codeview either focused or unfocused');
                  }
                }, onInit: () {
                  if (kDebugMode) {
                    print('init');
                  }
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
                    onImageUploadError: (FileUpload? file, String? base64Str,
                        UploadError error) {
                  if (kDebugMode) {
                    // print(describeEnum(error));
                    print(base64Str ?? '');
                  }
                  if (file != null) {
                    if (kDebugMode) {
                      print(file.name);
                      print(file.size);
                      print(file.type);
                    }
                  }
                }, onKeyDown: (int? keyCode) {
                  if (kDebugMode) {
                    print('$keyCode key downed');
                    print(
                        'current character count: ${widget.controller.characterCount}');
                  }
                }, onKeyUp: (int? keyCode) {
                  if (kDebugMode) {
                    print('$keyCode key released');
                  }
                }, onMouseDown: () {
                  if (kDebugMode) {
                    print('mouse downed');
                  }
                }, onMouseUp: () {
                  if (kDebugMode) {
                    print('mouse released');
                  }
                }, onNavigationRequestMobile: (String url) {
                  if (kDebugMode) {
                    print(url);
                  }
                  return NavigationActionPolicy.ALLOW;
                }, onPaste: () {
                  if (kDebugMode) {
                    print('pasted into editor');
                  }
                }, onScroll: () {
                  if (kDebugMode) {
                    print('editor scrolled');
                  }
                }),
                plugins: [
                  SummernoteAtMention(
                      getSuggestionsMobile: (String value) {
                        var mentions = <String>['test1', 'test2', 'test3'];
                        return mentions
                            .where((element) => element.contains(value))
                            .toList();
                      },
                      mentionsWeb: ['test1', 'test2', 'test3'],
                      onSelect: (String value) {
                        debugPrint(value);
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
                    widget.controller.undo();
                  },
                  child: Text(StringConstants.undo,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.color70gray),
                  onPressed: () {
                    widget.controller.clear();
                  },
                  child: Text(StringConstants.reset,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () {
                    widget.callback(data);
                  },
                  child: Text(
                    StringConstants.submit,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () {
                    widget.controller.redo();
                  },
                  child: Text(
                    StringConstants.redo,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(result),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.color70gray),
                  onPressed: () {
                    widget.controller.disable();
                  },
                  child: Text(StringConstants.disable,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () async {
                    widget.controller.enable();
                  },
                  child: Text(
                    StringConstants.enable,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
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
                    widget.controller.insertText('Google');
                  },
                  child: Text(StringConstants.insertTxt,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () {
                    widget.controller.insertHtml(
                        '''<p style="color: blue">Google in blue</p>''');
                  },
                  child: Text(StringConstants.html,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
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
                    widget.controller.insertLink(
                        'Google linked', 'https://google.com', true);
                  },
                  child: Text(
                    StringConstants.link,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () {
                    widget.controller.insertNetworkImage(
                        'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png',
                        filename: 'Google network image');
                  },
                  child: Text(
                    StringConstants.network,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
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
                    widget.controller.addNotification(
                        'Info notification', NotificationType.info);
                  },
                  child: Text(StringConstants.info,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.color70gray),
                  onPressed: () {
                    widget.controller.addNotification(
                        'Warning notification', NotificationType.warning);
                  },
                  child: Text(StringConstants.warning,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () async {
                    widget.controller.addNotification(
                        'Success notification', NotificationType.success);
                  },
                  child: Text(
                    StringConstants.success,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () {
                    widget.controller.addNotification(
                        'Danger notification', NotificationType.danger);
                  },
                  child: Text(
                    StringConstants.danger,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
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
                    widget.controller.addNotification(
                        'Plaintext notification', NotificationType.plaintext);
                  },
                  child: Text(StringConstants.plaintext,
                      style: AppTextStyles.infoContentStyle5
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
                ),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MakeMyTripColors.accentColor),
                  onPressed: () async {
                    widget.controller.removeNotification();
                  },
                  child: Text(
                    StringConstants.remove,
                    style: AppTextStyles.infoContentStyle5
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
