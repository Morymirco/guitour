import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ImageService {
  // Liste des images locales pour les sites touristiques
  static final Map<String, String> _localSiteImages = {
    'mont_nimba': 'assets/images/nimba1.jpg',
    'iles_de_loos': 'assets/images/ci.jpg',
    'chutes_de_kinkon': 'assets/images/s1.jpg',
    'parc_haut_niger': 'assets/images/parc_haut_niger.jpg',
    'foret_ziama': 'assets/images/foret_ziama.jpg',
    'plage_bel_air': 'assets/images/koule.jpg',
    'conakry': 'assets/images/conakry.jpg',
    'default': 'assets/images/dalaba.jpg',
  };

  // Liste des images distantes (URLs)
  static final Map<String, String> _remoteSiteImages = {
    'mont_nimba': 'https://example.com/images/mont_nimba.jpg',
    'iles_de_loos': 'https://example.com/images/iles_de_loos.jpg',
    'chutes_de_kinkon': 'https://example.com/images/chutes_de_kinkon.jpg',
    'parc_haut_niger': 'https://example.com/images/parc_haut_niger.jpg',
    'foret_ziama': 'https://example.com/images/foret_ziama.jpg',
    'plage_bel_air': 'https://example.com/images/plage_bel_air.jpg',
    'conakry': 'https://example.com/images/conakry.jpg',
  };

  // Obtenir une image locale par son identifiant
  static String getLocalImagePath(String imageId) {
    return _localSiteImages[imageId] ?? _localSiteImages['default']!;
  }

  // Obtenir une URL d'image distante par son identifiant
  static String? getRemoteImageUrl(String imageId) {
    return _remoteSiteImages[imageId];
  }

  // Widget pour afficher une image dynamique (locale ou distante)
  static Widget getDynamicImage({
    required String imageId,
    bool useRemoteIfAvailable = false,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    // Vérifier si on doit utiliser une image distante et si elle est disponible
    if (useRemoteIfAvailable && _remoteSiteImages.containsKey(imageId)) {
      return CachedNetworkImage(
        imageUrl: _remoteSiteImages[imageId]!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder ?? _buildDefaultPlaceholder(width, height),
        errorWidget: (context, url, error) => errorWidget ?? _buildDefaultErrorWidget(width, height),
        imageBuilder: (context, imageProvider) => _buildImageWithBorderRadius(
          imageProvider,
          width,
          height,
          fit,
          borderRadius,
        ),
      );
    } else {
      // Utiliser une image locale
      final String imagePath = getLocalImagePath(imageId);
      return _buildImageWithBorderRadius(
        AssetImage(imagePath),
        width,
        height,
        fit,
        borderRadius,
      );
    }
  }

  // Construire un widget d'image avec un borderRadius
  static Widget _buildImageWithBorderRadius(
    ImageProvider imageProvider,
    double? width,
    double? height,
    BoxFit fit,
    BorderRadius? borderRadius,
  ) {
    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image(
          image: imageProvider,
          width: width,
          height: height,
          fit: fit,
        ),
      );
    } else {
      return Image(
        image: imageProvider,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  // Widget de placeholder par défaut
  static Widget _buildDefaultPlaceholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
        ),
      ),
    );
  }

  // Widget d'erreur par défaut
  static Widget _buildDefaultErrorWidget(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
} 