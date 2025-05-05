import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_icon.dart';
import 'home_page.dart';

class connexion extends StatefulWidget {
  const connexion({super.key});

  @override
  State<connexion> createState() => _connexionState();
}

class _connexionState extends State<connexion> {
    int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                height: 350,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 0 ? 1 : 0, 
                        duration: Duration(seconds: 1,),
                        curve: Curves.linear,
                        child: Image.asset("assets/images/login.png")
                        // Image.network('https://ouch-cdn2.icons8.com/As6ct-Fovab32SIyMatjsqIaIjM9Jg1PblII8YAtBtQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNTg4/LzNmMDU5Mzc0LTky/OTQtNDk5MC1hZGY2/LTA2YTkyMDZhNWZl/NC5zdmc.png', height: 400,),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 1 ? 1 : 0, 
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child:  Image.asset("assets/images/login.png")
                        // Image.network('https://ouch-cdn2.icons8.com/vSx9H3yP2D4DgVoaFPbE4HVf6M4Phd-8uRjBZBnl83g/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNC84/MzcwMTY5OS1kYmU1/LTQ1ZmEtYmQ1Ny04/NTFmNTNjMTlkNTcu/c3Zn.png', height: 400,),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 2 ? 1 : 0, 
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child:  Image.asset("assets/images/login.jpg")
                        // Image.network('https://ouch-cdn2.icons8.com/fv7W4YUUpGVcNhmKcDGZp6pF1-IDEyCjSjtBB8-Kp_0/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMTUv/ZjUzYTU4NDAtNjBl/Yy00ZWRhLWE1YWIt/ZGM1MWJmYjBiYjI2/LnN2Zw.png', height: 400,),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 3 ? 1 : 0, 
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child: Image.asset("assets/images/login.png")
                        //  Image.network('https://ouch-cdn2.icons8.com/AVdOMf5ui4B7JJrNzYULVwT1z8NlGmlRYZTtg1F6z9E/rs:fit:784:767/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvOTY5/L2NlMTY1MWM5LTRl/ZjUtNGRmZi05MjQ3/LWYzNGQ1MzhiOTQ0/Mi5zdmc.png', height: 400,),
                      ),
                    )
                  ]
                ),
              ),
             Text("Connexion", style: TextStyle(fontSize: 22, color: AppColors.primaryGreen, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              TextField(
                cursorColor: AppColors.primaryGreen,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Email',
                  hintText: 'Username or e-mail',
                  labelStyle: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  prefixIcon: CustomIcon(
                    iconData: Iconsax.user,
                    color: AppColors.primaryGreen,
                    size: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                cursorColor: AppColors.primaryGreen,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Password',
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  labelStyle: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: CustomIcon(
                    iconData: Iconsax.key,
                    color: AppColors.primaryGreen,
                    size: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {}, 
                    child: Text('Forgot Password?', style: TextStyle(color: AppColors.primaryGold, fontSize: 14.0, fontWeight: FontWeight.w400),),
                  )
                ],
              ),
              SizedBox(height: 30,),
              MaterialButton(
                onPressed: (){
                  // Naviguer vers la page d'accueil
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                height: 45,
                color: AppColors.primaryGreen,
                child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0, fontWeight: FontWeight.w400),),
                  TextButton(
                    onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>inscription()));
                    }, 
                    child: Text('Register', style: TextStyle(color: AppColors.primaryGold, fontSize: 14.0, fontWeight: FontWeight.w400),),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}