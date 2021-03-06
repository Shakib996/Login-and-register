import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:login_page/auth/Login.dart';


class Regester extends StatefulWidget {
  const Regester({Key? key}) : super(key: key);

  @override
  _RegesterState createState() => _RegesterState();
}

class _RegesterState extends State<Regester> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation _animation;
  late TextEditingController _fullnameController =TextEditingController(text: '');
  late TextEditingController _emailController =TextEditingController(text: '');
  late TextEditingController _passwordController =TextEditingController(text: '');
  late TextEditingController _designationController =TextEditingController(text: '');

  bool _obsecureText=true;

  final _registerFormKey =GlobalKey<FormState>();

  FocusNode _fullnameFocusNode =FocusNode();
  FocusNode _emailFocusNode =FocusNode();
  FocusNode _passwordFocusNode =FocusNode();
  FocusNode _designationFocusNode =FocusNode();


  @override
  void dispose() {
    _animationController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _designationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 20));
    _animation =CurvedAnimation(parent: _animationController, curve: Curves.linear)..addListener(() {
      setState(() {

      });
    })..addStatusListener((animarionStatus) {
      if (animarionStatus==AnimationStatus.completed){
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
    super.initState();
  }

  void _submitFormRegister(){
    final isValid =_registerFormKey.currentState!.validate();
    print(';Invalid$isValid');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "https://images.pexels.com/photos/954599/pexels-photo-954599.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            placeholder: (context, url) => Image.asset("image/key.jpg"),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value,0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                SizedBox(height: size.height*0.1,),
                Text('Register',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                      TextSpan(text: ''),
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()
                            )),
                        text: 'Login',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Form(key: _registerFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_emailFocusNode),

                      focusNode: _fullnameFocusNode,
                      keyboardType: TextInputType.name,
                      controller: _fullnameController,
                      validator: (value){

                        if(value!.isEmpty){
                          return "Plz enter your valid password";
                        }else{return null;}
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Full name',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      onEditingComplete: ()=>_submitFormRegister(),
                      focusNode: _designationFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      controller: _designationController,
                      validator: (value){

                        if (value!.isEmpty){
                          return "Plz enter valid Email";
                        }else{return null;}
                      },

                      style:  TextStyle(color:  Colors.white),
                      decoration:  InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CupertinoColors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      obscureText: _obsecureText,
                      textInputAction: TextInputAction.next,
                      onEditingComplete:
                      ()=>FocusScope.of(context).requestFocus(_passwordFocusNode),
                      focusNode: _passwordFocusNode,
                      keyboardType:
                      TextInputType.visiblePassword,
                      controller: _passwordController,
                      validator: (value){

                        if (value!.isEmpty){
                          return'Plz enter valid password';
                        }else{return null;}
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    FlatButton(
                      onPressed: (){},
                      child: Text('Create',style: TextStyle(fontSize: 35,color: Colors.green),),
                    ),
                  ],
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
