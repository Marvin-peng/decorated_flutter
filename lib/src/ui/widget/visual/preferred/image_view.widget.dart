import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'preferred_async_builder.widget.dart';

typedef void LoadingProgress(double progress, List<int> data);

class ImageView extends StatelessWidget {
  ImageView.assetImage(
    this.imagePath, {
    Key key,
    this.width,
    this.height,
    this.size,
    this.fit,
    this.color,
  })  : imageUrl = null,
        svgPath = null,
        svgUrl = null,
        icon = null,
        imageUrlFuture = null,
        svgUrlFuture = null,
        iconFuture = null,
        fallbackAssetImage = null,
        fallbackImage = null,
        loadingProgress = null,
        loadFailedCallback = null,
        loadedCallback = null,
        useDiskCache = true,
        super(key: key);

  ImageView.networkImage(
    this.imageUrl, {
    Key key,
    this.width,
    this.height,
    this.size,
    this.fit,
    this.color,
    this.useDiskCache = true,
    this.fallbackAssetImage,
    this.fallbackImage,
    this.loadingProgress,
    this.loadFailedCallback,
    this.loadedCallback,
  })  : imagePath = null,
        svgUrl = null,
        icon = null,
        imageUrlFuture = null,
        svgUrlFuture = null,
        iconFuture = null,
        svgPath = null,
        super(key: key);

  ImageView.futureImage(
    this.imageUrlFuture, {
    Key key,
    this.width,
    this.height,
    this.size,
    this.fit,
    this.color,
    this.useDiskCache = true,
  })  : imagePath = null,
        svgUrl = null,
        icon = null,
        imageUrl = null,
        svgUrlFuture = null,
        iconFuture = null,
        fallbackAssetImage = null,
        fallbackImage = null,
        loadingProgress = null,
        loadFailedCallback = null,
        loadedCallback = null,
        svgPath = null,
        super(key: key);

  ImageView.assetSvg(
    this.svgPath, {
    Key key,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.contain,
    this.color,
  })  : imageUrl = null,
        imagePath = null,
        svgUrl = null,
        icon = null,
        imageUrlFuture = null,
        svgUrlFuture = null,
        iconFuture = null,
        fallbackAssetImage = null,
        fallbackImage = null,
        loadingProgress = null,
        loadFailedCallback = null,
        loadedCallback = null,
        useDiskCache = true,
        super(key: key);

  ImageView.networkSvg(
    this.svgUrl, {
    Key key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.size,
    this.color,
    this.useDiskCache = true,
  })  : imageUrl = null,
        imagePath = null,
        icon = null,
        imageUrlFuture = null,
        svgUrlFuture = null,
        iconFuture = null,
        fallbackAssetImage = null,
        fallbackImage = null,
        loadingProgress = null,
        loadFailedCallback = null,
        loadedCallback = null,
        svgPath = null,
        super(key: key);

  ImageView.futureSvg(
    this.svgUrlFuture, {
    Key key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.size,
    this.color,
    this.useDiskCache = true,
  })  : imageUrl = null,
        imagePath = null,
        svgUrl = null,
        icon = null,
        imageUrlFuture = null,
        iconFuture = null,
        fallbackAssetImage = null,
        fallbackImage = null,
        loadingProgress = null,
        loadFailedCallback = null,
        loadedCallback = null,
        svgPath = null,
        super(key: key);

  ImageView.icon(
    this.icon, {
    Key key,
    this.size,
    this.color,
  })  : imageUrl = null,
        imagePath = null,
        svgPath = null,
        svgUrl = null,
        width = null,
        height = null,
        fit = null,
        imageUrlFuture = null,
        svgUrlFuture = null,
        iconFuture = null,
        fallbackAssetImage = null,
        fallbackImage = null,
        loadingProgress = null,
        loadFailedCallback = null,
        loadedCallback = null,
        useDiskCache = null,
        super(key: key);

  ImageView.futureIcon(
    this.iconFuture, {
    Key key,
    this.size,
    this.color,
  })  : imageUrl = null,
        imagePath = null,
        svgPath = null,
        svgUrl = null,
        width = null,
        height = null,
        fit = null,
        imageUrlFuture = null,
        svgUrlFuture = null,
        icon = null,
        fallbackAssetImage = null,
        fallbackImage = null,
        loadingProgress = null,
        loadFailedCallback = null,
        loadedCallback = null,
        useDiskCache = null,
        super(key: key);

  /// 本地图片路径
  final String imagePath;

  /// 图片url
  final String imageUrl;

  /// 本地svg路径
  final String svgPath;

  /// svg的url
  final String svgUrl;

  /// 宽度 如果同时设置了[width], [height]和[size], 那么优先[size]
  final double width;

  /// 高度 如果同时设置了[width], [height]和[size], 那么优先[size]
  final double height;

  /// 适应模式
  final BoxFit fit;

  /// 颜色
  final Color color;

  /// 是否使用硬盘缓存
  final bool useDiskCache;

  /// 备用的asset image路径
  final String fallbackAssetImage;

  /// 备用的Image
  final Uint8List fallbackImage;

  /// 加载失败回调
  final VoidCallback loadFailedCallback;

  /// 加载进度回调
  final LoadingProgress loadingProgress;

  /// 加载完成回调
  final VoidCallback loadedCallback;

  /// icon
  final IconData icon;

  /// 大小, 如果同时设置了[width], [height]和[size], 那么优先[size]
  final double size;

  /// 需要异步获取的图片url
  final Future<String> imageUrlFuture;

  /// 需要异步获取的svg url
  final Future<String> svgUrlFuture;

  /// 需要异步获取的icon
  final Future<IconData> iconFuture;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return Image.asset(
        imagePath,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
        color: color,
        gaplessPlayback: true,
      );
    } else if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
        color: color,
        errorWidget: (_, __, ___) => Image.asset(
          fallbackAssetImage,
          width: size ?? width,
          height: size ?? height,
        ),
      );
    } else if (svgPath != null) {
      return SvgPicture.asset(
        svgPath,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
        color: color,
      );
    } else if (svgUrl != null) {
      return SvgPicture.network(
        svgUrl,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
        color: color,
      );
    } else if (imageUrlFuture != null) {
      return PreferredFutureBuilder<String>(
        future: imageUrlFuture,
        showLoading: false,
        builder: (data) {
          return ImageView.networkImage(
            data,
            width: size ?? width,
            height: size ?? height,
            fit: fit,
            color: color,
            useDiskCache: useDiskCache,
          );
        },
      );
    } else if (svgUrlFuture != null) {
      return PreferredFutureBuilder<String>(
        future: svgUrlFuture,
        showLoading: false,
        builder: (data) {
          return ImageView.networkSvg(
            data,
            width: size ?? width,
            height: size ?? height,
            fit: fit,
            color: color,
          );
        },
      );
    } else if (iconFuture != null) {
      return PreferredFutureBuilder<IconData>(
        future: iconFuture,
        showLoading: false,
        builder: (data) {
          return ImageView.icon(
            data,
            size: size ?? width,
            color: color,
          );
        },
      );
    } else if (icon != null) {
      return Icon(icon, size: size, color: color);
    } else {
      // 如果图片地址为null的话, 那就不显示
      return SizedBox.shrink();
    }
  }
}
