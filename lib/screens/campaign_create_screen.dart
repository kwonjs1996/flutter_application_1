import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CampaignCreateScreen extends StatefulWidget {
  @override
  _CampaignCreateScreenState createState() => _CampaignCreateScreenState();
}

class _CampaignCreateScreenState extends State<CampaignCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  int maxParticipants = 10;
  String reward = '';
  DateTime? deadline;
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // ✅ 캠페인 등록 로직 (Firebase Firestore 등 연동 가능)
      print("캠페인 등록: $title, $description, 모집: $maxParticipants, 보상: $reward, 마감일: $deadline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("캠페인 등록")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "캠페인 제목"),
                validator: (value) => value!.isEmpty ? "제목을 입력하세요" : null,
                onChanged: (value) => title = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "설명"),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? "설명을 입력하세요" : null,
                onChanged: (value) => description = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "모집 인원"),
                keyboardType: TextInputType.number,
                onChanged: (value) => maxParticipants = int.tryParse(value) ?? 10,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "보상"),
                onChanged: (value) => reward = value,
              ),
              ListTile(
                title: Text(deadline == null ? "마감일 선택" : "마감일: ${deadline!.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      deadline = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              _image == null
                  ? Text("이미지를 선택하세요")
                  : Image.file(_image!, height: 150, fit: BoxFit.cover),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text("이미지 선택"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("캠페인 등록하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
