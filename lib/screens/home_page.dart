import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../services/image_service.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_icon.dart';
import 'site_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        title: Text(
          "Découvrez la Guinée",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.notification, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Iconsax.setting, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Rechercher un lieu touristique...",
                  prefixIcon: Icon(Iconsax.search_normal, color: AppColors.primaryGreen),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.primaryGreen),
                  ),
                ),
              ),
            ),
            
            // Bannière principale
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage("assets/images/nimba1.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryGreen.withOpacity(0.2),
                      BlendMode.srcOver,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Explorez les merveilles de Guinée",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Découvrez la richesse naturelle et culturelle",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 25),
            
            // Régions de Guinée
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Régions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
            
            SizedBox(height: 15),
            
            // Liste horizontale des régions avec possibilité d'utiliser des SVG
            Container(
              height: 100,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCardWithCustomIcon("Conakry", iconData: Iconsax.building_4),
                  _buildCategoryCardWithCustomIcon("Basse Guinée", svgName: "coast"),
                  _buildCategoryCardWithCustomIcon("Moyenne Guinée", svgName: "mountain"),
                  _buildCategoryCardWithCustomIcon("Haute Guinée", iconData: Iconsax.sun_1),
                  _buildCategoryCardWithCustomIcon("Guinée Forestière", iconData: Iconsax.tree),
                ],
              ),
            ),
            
            SizedBox(height: 25),
            
            // Catégories de lieux
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Catégories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
            
            SizedBox(height: 15),
            
            // Liste horizontale des catégories avec possibilité d'utiliser des SVG
            Container(
              height: 100,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCardWithCustomIcon("Plages", svgName: "beach"),
                  _buildCategoryCardWithCustomIcon("Montagnes", svgName: "mountain-categorie"),
                  _buildCategoryCardWithCustomIcon("Chutes d'eau", svgName: "waterfalls"),
                  _buildCategoryCardWithCustomIcon("Parcs", svgName: "park"),
                  _buildCategoryCardWithCustomIcon("Culture", svgName: "culture"),
                ],
              ),
            ),
            
            SizedBox(height: 25),
            
            // Destinations populaires
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Destinations populaires",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Voir tout",
                      style: TextStyle(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 15),
            
            // Liste horizontale des destinations populaires
            Container(
              height: 250,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDestinationCard("Mont Nimba", "Lola, Guinée Forestière", 4.8),
                  _buildDestinationCard("Îles de Loos", "Conakry", 4.7),
                  _buildDestinationCard("Chutes de Kinkon", "Pita, Moyenne Guinée", 4.6),
                  _buildDestinationCard("Parc National du Haut Niger", "Faranah", 4.5),
                ],
              ),
            ),
            
            SizedBox(height: 25),
            
            // Lieux à proximité
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "À proximité de vous",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
            
            SizedBox(height: 15),
            
            // Liste des lieux à proximité
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildNearbyPlaceItem("Palais du Peuple", "Conakry", "2.5 km", 4.3),
                  _buildNearbyPlaceItem("Plage de Bel Air", "Conakry", "3.8 km", 4.6),
                  _buildNearbyPlaceItem("Marché Madina", "Conakry", "1.2 km", 4.1),
                  _buildNearbyPlaceItem("Mosquée Fayçal", "Conakry", "4.5 km", 4.7),
                ],
              ),
            ),
            
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.map),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return _buildCategoryCardWithCustomIcon(title, iconData: icon);
  }

  Widget _buildDestinationCard(String name, String location, double rating) {
    String imageId = _getImageIdFromName(name);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SiteDetailPage(
              name: name,
              location: location,
              rating: rating,
              imageId: imageId,
              description: "Ce site touristique magnifique offre une expérience unique en Guinée. Avec sa beauté naturelle exceptionnelle et son importance culturelle, c'est une destination incontournable pour les voyageurs à la recherche d'authenticité et d'aventure.",
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 15, left: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageService.getDynamicImage(
              imageId: imageId,
              height: 150,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 14,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: AppColors.primaryGold,
                      ),
                      SizedBox(width: 5),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getImageIdFromName(String name) {
    switch (name.toLowerCase()) {
      case 'mont nimba':
        return 'mont_nimba';
      case 'îles de loos':
        return 'iles_de_loos';
      case 'chutes de kinkon':
        return 'chutes_de_kinkon';
      case 'parc national du haut niger':
        return 'parc_haut_niger';
      case 'forêt de ziama':
        return 'foret_ziama';
      case 'plage de bel air':
        return 'plage_bel_air';
      case 'conakry':
        return 'conakry';
      default:
        return 'default';
    }
  }

  Widget _buildNearbyPlaceItem(String name, String location, String distance, double rating) {
    String imageId = _getImageIdFromName(name);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SiteDetailPage(
              name: name,
              location: location,
              rating: rating,
              imageId: imageId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          leading: Container(
            width: 60,
            height: 60,
            child: ImageService.getDynamicImage(
              imageId: imageId,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Iconsax.location,
                    size: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    distance,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: AppColors.primaryGold,
                  ),
                  SizedBox(width: 5),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Icon(
            Iconsax.arrow_right_3,
            color: AppColors.primaryGreen,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCardWithCustomIcon(String title, {IconData? iconData, String? svgName}) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 15, left: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: CustomIcon(
              iconData: iconData,
              svgName: svgName,
              size: 30,
              color: AppColors.primaryGold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
} 