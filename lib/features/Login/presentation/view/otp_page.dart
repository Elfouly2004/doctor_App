import 'package:doctor/core/background_image/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String otpCode = '';

  void _submitOtp() {
    if (otpCode.length == 6) {
      // نفذ التحقق هنا
      print('OTP entered: $otpCode');
      // مثلاً:
      // verifyOtp(otpCode);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter 6 digits')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
      ),
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the 6-digit code sent to your Email',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              OtpTextField(
                numberOfFields: 6,
                borderColor: Colors.blue,
                focusedBorderColor: Colors.black,
                showFieldAsBox: true,
                onSubmit: (String code) {
                  setState(() {
                    otpCode = code;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitOtp,
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
