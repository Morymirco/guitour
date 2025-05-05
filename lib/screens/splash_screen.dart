import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';

import '../theme/app_colors.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Configuration des animations
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );
    
    // Démarrer l'animation
    _animationController.forward();
    
    // Configurer la redirection après un délai
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => connexion()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryGreen,
              AppColors.darkGreen,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo AVIF animé qui occupe tout le conteneur
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          // Utilisation de ClipOval pour s'assurer que l'image est parfaitement circulaire
                          child: ClipOval(
                            child: AvifImage.asset(
                              'assets/animations/logo_animation.avif',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover, // Utilisation de cover pour remplir tout l'espace
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/logo.jpg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        
                        // Titre de l'application
                        Text(
                          "Découvrez la Guinée",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 10),
                        
                        // Slogan ou description
                        Text(
                          "Explorez les merveilles touristiques",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                        
                        SizedBox(height: 60),
                        
                        // Indicateur de chargement
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGold),
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
} 