import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


import 'regester.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double>_animation;
  late TextEditingController _emailController=TextEditingController(text: '');
  late TextEditingController _passwordController=TextEditingController(text: '');
  bool _obseureText=true;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(seconds: 20));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)..addListener(() {
      setState(() {

      });
    })..addStatusListener((animationStatus) {
      if (animationStatus==AnimationStatus){
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "https://www.cnet.com/a/img/-qQkzFVyOPEoBRS7K5kKS0GFDvk=/940x0/2020/04/16/7d6d8ed2-e10c-4f91-b2dd-74fae951c6d8/bazaart-edit-app.jpg",
            placeholder: (context, url) => Image.asset("image/thinking.jpg"),
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
                SizedBox(height: size.height*.1,),
                Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t Have an Account',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.orange),
                      ),
                      TextSpan(text: ''),
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Regester()
                            )),
                        text: 'Register',
                        style: TextStyle(color: Colors.lightGreen,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ]
                  ),
                ),
                SizedBox(height: 40,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  style: TextStyle(color: Colors.orangeAccent),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: _obseureText,
                  validator: (value){

                    if (value!.isEmpty|| value.length<8){
                      return 'Please enter your valid password';
                    }else{
                      return null;
                    }
                  },
                  style: TextStyle(color: Colors.orangeAccent),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(height: 250,),
                FlatButton(
                  onPressed: (){},
                  child: Text('Submit',style: TextStyle(fontSize: 30,color: Colors.red),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
