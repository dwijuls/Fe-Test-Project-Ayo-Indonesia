enum AssetGambar {
  iconsAvatar,
  iconsAva_1,
  iconsAva_2,
  iconsAva_3,
  iconsAvaPodium1,
  iconsAvaPodium2,
  iconsAvaPodium3,
  iconsQuestion,
  iconsEmpty,
  iconsCrown,
  backAccent,
}

class DrawableX{
  static String imageAsset(AssetGambar assetGambar){
    switch (assetGambar){
      // Icons
      case AssetGambar.iconsAvatar           : return "assets/components/icons/avatar.png";
      case AssetGambar.iconsAva_1            : return "assets/components/icons/ava_1.png";
      case AssetGambar.iconsAva_2            : return "assets/components/icons/ava_2.png";
      case AssetGambar.iconsAva_3            : return "assets/components/icons/ava_3.png";
      case AssetGambar.iconsAvaPodium1       : return "assets/components/icons/ava-podium-1.png";
      case AssetGambar.iconsAvaPodium2       : return "assets/components/icons/ava-podium-2.png";
      case AssetGambar.iconsAvaPodium3       : return "assets/components/icons/ava-podium-3.png";
      case AssetGambar.iconsQuestion         : return "assets/components/icons/question.png";
      case AssetGambar.iconsEmpty            : return "assets/components/icons/empty.png";
      case AssetGambar.iconsCrown            : return "assets/components/icons/crown.png";

      // Background
      case AssetGambar.backAccent             : return "assets/components/background/background-accent.png";
    }
  }
}
