import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projekatmobilne/consts/validator.dart';
import 'package:projekatmobilne/services/assets_manager.dart';
import 'package:projekatmobilne/services/my_app_functions.dart';
import 'package:projekatmobilne/widgets/auth/image_picker_widget.dart';
import 'package:projekatmobilne/widgets/subtitle_text.dart';
import 'package:projekatmobilne/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  static const routName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool obscureText = true;

  XFile? _pickedImage;

  bool _isLoading = false;

  final auth = FirebaseAuth.instance;

  late final TextEditingController
      _nameController,
      _emailController,
      _passwordController,
      _repeatPasswordController;

  late final FocusNode
      _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();


  @override
  void initState() {

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();

    super.dispose();
  }


  Future<void> _registerFCT() async {

    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!isValid) {
      return;
    }

    try {

      setState(() {
        _isLoading = true;
      });

      await auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Fluttertoast.showToast(
        msg: "Registracija uspešna!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

    } on FirebaseAuthException catch (error) {

      Fluttertoast.showToast(
        msg: error.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );

    } catch (error) {

      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );

    } finally {

      setState(() {
        _isLoading = false;
      });

    }
  }



  Future<void> localImagePicker() async {

    final ImagePicker imagePicker = ImagePicker();

    await MyAppFunctions.imagePickerDialog(

      context: context,

      cameraFCT: () async {

        _pickedImage = await imagePicker.pickImage(
          source: ImageSource.camera,
        );

        setState(() {});
      },

      galleryFCT: () async {

        _pickedImage = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );

        setState(() {});
      },

      removeFCT: () {

        setState(() {
          _pickedImage = null;
        });

      },

    );
  }



  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GestureDetector(

      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(

        body: Padding(

          padding: const EdgeInsets.all(8.0),

          child: SingleChildScrollView(

            child: Column(

              children: [

                const SizedBox(height: 60),

                Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Image.asset(
                      "${AssetsManager.imagePath}/logo.png",
                      height: 60,
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      "Sweet Haven",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],

                ),

                const SizedBox(height: 30),

                const Align(

                  alignment: Alignment.centerLeft,

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      TitelesTextWidget(label: "Kreiraj nalog"),

                      SubtitleTextWidget(
                        label: "Registruj se i uživaj u Sweet Haven poslasticama",
                      ),

                    ],

                  ),

                ),

                const SizedBox(height: 30),

                SizedBox(

                  height: size.width * 0.3,
                  width: size.width * 0.3,

                  child: PickImageWidget(

                    pickedImage: _pickedImage,

                    function: () async {
                      await localImagePicker();
                    },

                  ),

                ),

                const SizedBox(height: 30),

                Form(

                  key: _formkey,

                  child: Column(

                    children: [

                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_emailFocusNode);
                        },
                        validator: (value) {
                          return MyValidators.displayNamevalidator(value);
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email adresa",
                          prefixIcon: Icon(IconlyLight.message),
                        ),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.next,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "***********",
                          prefixIcon: const Icon(IconlyLight.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _repeatPasswordController,
                        focusNode: _repeatPasswordFocusNode,
                        textInputAction: TextInputAction.done,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "Repeat password",
                          prefixIcon: const Icon(IconlyLight.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (value) async {
                          await _registerFCT();
                        },
                        validator: (value) {
                          return MyValidators.repeatPasswordValidator(
                            value: value,
                            password: _passwordController.text,
                          );
                        },
                      ),

                      const SizedBox(height: 36),

                      SizedBox(

                        width: double.infinity,

                        child: ElevatedButton.icon(

                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),

                          icon: const Icon(IconlyLight.addUser),

                          label: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Kreiraj nalog"),

                          onPressed: () async {
                            await _registerFCT();
                          },

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

    );

  }

}