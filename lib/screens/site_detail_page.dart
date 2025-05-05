import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_icon.dart';
import '../services/image_service.dart';  // Importez le service d'images

class SiteDetailPage extends StatefulWidget {
  final String name;
  final String location;
  final double rating;
  final String imageId;  // Utiliser imageId au lieu de imageUrl
  final String? description;

  const SiteDetailPage({
    Key? key,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageId,  // Paramètre modifié
    this.description,
  }) : super(key: key);

  @override
  State<SiteDetailPage> createState() => _SiteDetailPageState();
}

class _SiteDetailPageState extends State<SiteDetailPage> with TickerProviderStateMixin {
  bool isFavorite = false;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_showTitle) {
      setState(() {
        _showTitle = true;
      });
    } else if (_scrollController.offset <= 200 && _showTitle) {
      setState(() {
        _showTitle = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primaryGreen,
              leading: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: AppColors.primaryGreen),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : AppColors.primaryGreen,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
                IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.share, color: AppColors.primaryGreen),
                  ),
                  onPressed: () {
                    // Fonctionnalité de partage
                  },
                ),
                SizedBox(width: 8),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: _showTitle ? Text(widget.name) : null,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image principale avec le service d'images
                    ImageService.getDynamicImage(
                      imageId: widget.imageId,
                      useRemoteIfAvailable: true,  // Essayer d'utiliser une image distante si disponible
                      fit: BoxFit.cover,
                    ),
                    // Dégradé pour améliorer la lisibilité
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: [0.7, 1.0],
                        ),
                      ),
                    ),
                    // Informations en bas de l'image
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.location,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.star,
                                color: AppColors.primaryGold,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.rating.toString(),
                                style: TextStyle(
                                  color: Colors.white,
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
            ),
            // Ajoutez une nouvelle SliverPersistentHeader pour les onglets
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primaryGold,
                  labelColor: AppColors.primaryGreen,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 3.0,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  tabs: [
                    Tab(text: "À propos"),
                    Tab(text: "Photos"),
                    Tab(text: "Avis"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Onglet À propos
            _buildAboutTab(),
            
            // Onglet Photos
            _buildPhotosTab(),
            
            // Onglet Avis
            _buildReviewsTab(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action pour ouvrir la carte
                },
                icon: Icon(Iconsax.map),
                label: Text("Voir sur la carte"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Text(
            "Description",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 8),
          Text(
            widget.description ?? 
            "Ce site touristique magnifique offre une expérience unique en Guinée. Avec sa beauté naturelle exceptionnelle et son importance culturelle, c'est une destination incontournable pour les voyageurs à la recherche d'authenticité et d'aventure. Profitez de paysages à couper le souffle et découvrez la richesse du patrimoine guinéen.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24),
          
          // Caractéristiques
          Text(
            "Caractéristiques",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildFeatureItem(Iconsax.clock, "Durée recommandée", "2-3 heures"),
              SizedBox(width: 16),
              _buildFeatureItem(Iconsax.money, "Prix d'entrée", "10 000 GNF"),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildFeatureItem(Iconsax.calendar, "Meilleure période", "Oct-Avr"),
              SizedBox(width: 16),
              _buildFeatureItem(Iconsax.activity, "Niveau de difficulté", "Facile"),
            ],
          ),
          SizedBox(height: 24),
          
          // Informations pratiques
          Text(
            "Informations pratiques",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 16),
          _buildInfoItem(
            Iconsax.clock, 
            "Horaires d'ouverture", 
            "Lun-Dim: 8h00 - 18h00"
          ),
          Divider(),
          _buildInfoItem(
            Iconsax.call, 
            "Contact", 
            "+224 62 12 34 56"
          ),
          Divider(),
          _buildInfoItem(
            Iconsax.global, 
            "Site web", 
            "www.tourisme-guinee.com"
          ),
          Divider(),
          _buildInfoItem(
            Iconsax.location, 
            "Adresse", 
            "Route Nationale 1, Kindia, Guinée"
          ),
          SizedBox(height: 24),
          
          // Services disponibles
          Text(
            "Services disponibles",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildServiceChip("Parking", Iconsax.car),
              _buildServiceChip("Restauration", Iconsax.coffee),
              _buildServiceChip("Toilettes", Iconsax.building_3),
              _buildServiceChip("Guide", Iconsax.user),
              _buildServiceChip("Boutique", Iconsax.shopping_bag),
              _buildServiceChip("Wifi", Iconsax.wifi),
            ],
          ),
          SizedBox(height: 24),
          
          // Activités à proximité
          Text(
            "Activités à proximité",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 16),
          _buildNearbyActivityItem(
            "Randonnée guidée",
            "Découvrez les sentiers naturels avec un guide local",
            "5 km",
            4.5,
          ),
          SizedBox(height: 12),
          _buildNearbyActivityItem(
            "Marché artisanal",
            "Achetez des souvenirs et de l'artisanat local",
            "2 km",
            4.2,
          ),
          SizedBox(height: 12),
          _buildNearbyActivityItem(
            "Restaurant traditionnel",
            "Goûtez à la cuisine guinéenne authentique",
            "1 km",
            4.7,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPhotosTab() {
    // Liste des IDs d'images liées au site
    List<String> relatedImageIds = _getRelatedImageIds();
    
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: relatedImageIds.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Afficher l'image en plein écran
            _showFullScreenImage(context, relatedImageIds[index]);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImageService.getDynamicImage(
              imageId: relatedImageIds[index],
              useRemoteIfAvailable: true,
            ),
          ),
        );
      },
    );
  }

  // Méthode pour obtenir les IDs d'images liées au site principal
  List<String> _getRelatedImageIds() {
    // Vous pouvez personnaliser cette logique selon vos besoins
    switch (widget.imageId) {
      case 'mont_nimba':
        return ['mont_nimba', 'mont_nimba', 'mont_nimba', 'mont_nimba'];
      case 'iles_de_loos':
        return ['iles_de_loos', 'iles_de_loos', 'iles_de_loos', 'iles_de_loos'];
      case 'chutes_de_kinkon':
        return ['chutes_de_kinkon', 'chutes_de_kinkon', 'chutes_de_kinkon', 'chutes_de_kinkon'];
      default:
        return [widget.imageId, widget.imageId, widget.imageId, widget.imageId];
    }
  }

  // Méthode pour afficher une image en plein écran
  void _showFullScreenImage(BuildContext context, String imageId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 4,
              child: ImageService.getDynamicImage(
                imageId: imageId,
                useRemoteIfAvailable: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // En-tête des avis
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Avis des visiteurs",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Basé sur 45 avis",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      widget.rating.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.star,
                      color: AppColors.primaryGold,
                      size: 22,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Excellent",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
        
        SizedBox(height: 16),
        
        // Bouton pour ajouter un avis
        ElevatedButton(
          onPressed: () {
            // Action pour ajouter un avis
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primaryGreen,
            side: BorderSide(color: AppColors.primaryGreen),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Écrire un avis"),
        ),
        
        SizedBox(height: 24),
        
        // Liste des avis
        _buildReviewItem(
          "Amadou Diallo",
          5.0,
          "Un endroit magnifique ! J'ai adoré la vue panoramique et l'accueil chaleureux. Je recommande vivement cette destination à tous les amoureux de la nature.",
          "Il y a 2 jours",
        ),
        Divider(),
        _buildReviewItem(
          "Mariama Camara",
          4.5,
          "Très belle expérience. Le site est bien entretenu et les guides sont très professionnels. Seul bémol, le prix un peu élevé pour les services proposés.",
          "Il y a 1 semaine",
        ),
        Divider(),
        _buildReviewItem(
          "Ibrahim Soumah",
          5.0,
          "Un joyau de la Guinée ! J'ai été impressionné par la beauté naturelle et la richesse culturelle de ce lieu. À ne pas manquer lors de votre visite en Guinée.",
          "Il y a 2 semaines",
        ),
        Divider(),
        _buildReviewItem(
          "Fatoumata Bah",
          4.0,
          "Belle découverte. L'endroit est magnifique mais pourrait bénéficier de meilleures infrastructures pour les visiteurs. Les sentiers sont parfois difficiles à suivre.",
          "Il y a 1 mois",
        ),
        
        SizedBox(height: 16),
        
        // Bouton pour voir plus d'avis
        TextButton(
          onPressed: () {
            // Action pour voir plus d'avis
          },
          child: Text(
            "Voir tous les avis",
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppColors.primaryGold,
              size: 20,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryGreen,
            size: 20,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.primaryGreen,
            size: 16,
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyActivityItem(String title, String description, String distance, double rating) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Iconsax.activity,
              color: AppColors.primaryGold,
              size: 30,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      size: 12,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      distance,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.star,
                      size: 12,
                      color: AppColors.primaryGold,
                    ),
                    SizedBox(width: 4),
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
          ),
          Icon(
            Iconsax.arrow_right_3,
            color: AppColors.primaryGreen,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, double rating, String comment, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryGreen.withOpacity(0.2),
                child: Text(
                  name.substring(0, 1),
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < rating.floor() ? Icons.star : (index < rating ? Icons.star_half : Icons.star_border),
                          color: AppColors.primaryGold,
                          size: 14,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            comment,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Ajoutez cette classe déléguée pour les onglets
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
} 