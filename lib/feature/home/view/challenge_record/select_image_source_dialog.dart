import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageSourceDialog extends StatelessWidget {
  const SelectImageSourceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSourceOption(
                context,
                icon: Icons.camera_alt_outlined,
                text: '카메라',
                source: ImageSource.camera
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _buildSourceOption(
                context,
                icon: Icons.photo_outlined,
                text: '갤러리',
                source: ImageSource.gallery
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption(
      BuildContext context, {
        required IconData icon,
        required String text,
        required ImageSource source
      }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () => Navigator.of(context).pop(source),
    );
  }

  Future<ImageSource?> show(BuildContext context) async {
    return await showDialog<ImageSource>(
      context: context,
      builder: (context) => this,
    );
  }
}
