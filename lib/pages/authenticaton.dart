import 'package:expance_manager/functions/auth.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}


class _LoginpageState extends State<Loginpage> {

  final _formkey  = GlobalKey<FormState>();

  bool islogin = false;
  String emailaddress = '';
  String password = '';
  String username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: EdgeInsets.symmetric(horizontal: 10), child: islogin ?  Text("Create an Account" , style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) : Text("Welcome back!!" , style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
              SizedBox(height: 25,),
              Form(key:_formkey, child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [ !islogin ? Container():
                  TextFormField(
                    key: ValueKey('username'),
                    style: TextStyle(fontSize: 18,color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.verified_user_outlined),
                      hintText: 'Username',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    validator: (value){
                      if(value.toString().length<3){
                         return 'too Sort Write Greter than 5 letter';
                         }
                      else{
                        return null;
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        username = value!;
                      });
                    },
                  ),
                  SizedBox(height: 15,),

                  TextFormField(
                    key: ValueKey('email'),
                    style: TextStyle(color: Colors.black,fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    validator: (value){
                      if(value.toString().isEmpty){
                        return 'Enter Emial';
                      }
                      else {
                        return null;
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        emailaddress = value!;
                      });
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    key: ValueKey('password'),
                    style: TextStyle(fontSize:18,color:Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                hintText: 'Comfirm Password',contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
                )
              ),
              validator: (value) {
                if(value.toString().length<6){
                  return 'Password is short create 6 or mmore letter';
                }
                return null;
              },
              onSaved: (value){
                setState(() {
                  password = value!;
                });
              },
            ),
            SizedBox(height: 25,),
            ElevatedButton(onPressed: (){
              if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          !islogin ? signup(emailaddress, password) : signin(emailaddress, password);
                        }
                      }
                      ,style: ElevatedButton.styleFrom(
              backgroundColor:Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
            ), child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold ),),)  ,
              SizedBox(
                height: 15,
              ),
                TextButton(onPressed: (){
                  setState(() {
                    islogin = !islogin;
                  });
                }, child : !islogin ? Text("Create an account?",style: TextStyle(color: Colors.blue),) :  Text("Already login ?",style: TextStyle(color: Colors.blue),))
                ],
              ),
              ))
            ],
          ),
      ),
    );
  }
}