import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateCodeScreen extends StatefulWidget {
  const CreateCodeScreen({super.key});

  @override
  State<CreateCodeScreen> createState() => _CreateCodeScreenState();
}

class _CreateCodeScreenState extends State<CreateCodeScreen> {
  String codeType = 'QR';
  File? _image;
  final TextEditingController receiverController = TextEditingController();
  final TextEditingController productTypeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  DateTime? expiryDate;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _image = null;
    });
  }

  void _editImage() {
    _pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기프티콘 등록'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '기프티콘 타입',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  FilterChip.elevated(
                    chipAnimationStyle: ChipAnimationStyle(
                      enableAnimation: AnimationStyle(
                        duration: const Duration(seconds: 3),
                        reverseDuration: const Duration(seconds: 1),
                      ),
                    ),
                    onSelected: (bool value) {
                      setState(() {
                        codeType = 'QR';
                      });
                    },
                    backgroundColor:
                        codeType == 'QR' ? Colors.amber : Colors.grey[300],
                    label: Text(
                      'QR',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilterChip.elevated(
                    chipAnimationStyle: ChipAnimationStyle(
                      enableAnimation: AnimationStyle(
                        duration: const Duration(seconds: 3),
                        reverseDuration: const Duration(seconds: 1),
                      ),
                    ),
                    onSelected: (bool value) {
                      setState(() {
                        codeType = '바코드';
                      });
                    },
                    backgroundColor:
                        codeType == '바코드' ? Colors.amber : Colors.grey[300],
                    label: Text('바코드'),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    '상품 이미지',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 35),
                  if (_image != null)
                    Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: Drawer(
                                child: Image.file(_image!, fit: BoxFit.cover),
                              )),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: _editImage, // 수정 버튼
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: _deleteImage, // 삭제 버튼
                            ),
                          ],
                        )
                      ],
                    )
                  else
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey[300],
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: Center(
                            child: Icon(Icons.camera_alt, size: 50),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
