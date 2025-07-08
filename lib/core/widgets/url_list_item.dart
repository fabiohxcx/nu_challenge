import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nu_challenge/core/assets/app_svgs.dart';
import 'package:nu_challenge/core/theme/app_colors.dart';
import 'package:nu_challenge/core/theme/app_sizes.dart';
import 'package:nu_challenge/core/theme/app_spacing.dart';
import 'package:nu_challenge/core/theme/app_text_styles.dart';
import 'package:nu_challenge/data/models/url_alias_response.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlListItem extends StatelessWidget {
  final int index;
  final UrlAliasResponse urlAlias;

  const UrlListItem({super.key, required this.index, required this.urlAlias});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String urlString = urlAlias.links.self;

        if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
          // Se não começar, adiciona https:// como padrão
          urlString = 'https://$urlString';
        }

        final Uri url = Uri.parse(urlString);

        final bool canLaunch = await launchUrl(url, mode: LaunchMode.externalApplication);

        if (!context.mounted) return;

        if (!canLaunch) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not launch $url")));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.neutral100, width: 1.0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "# ${index + 1}",
                    style: context.bodySmall?.copyWith(color: AppColors.neutral700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    urlAlias.alias,
                    style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: context.colors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    urlAlias.links.self,
                    style: context.bodySmall?.copyWith(color: AppColors.neutral700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              AppSvgs.openLink,
              semanticsLabel: 'Open Link',
              height: AppSizes.iconSizeMd,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
