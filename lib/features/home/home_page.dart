import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_challenge/core/theme/app_colors.dart';
import 'package:nu_challenge/core/theme/app_sizes.dart';
import 'package:nu_challenge/core/theme/app_spacing.dart';
import 'package:nu_challenge/core/theme/app_text_styles.dart';

import '../../app_routes.dart';
import '../../core/widgets/url_list_item.dart';
import 'home_cubit.dart';

/// The main screen of the application where users can shorten URLs.
///
/// This page features a text field to input a URL, a button to initiate the
/// shortening process, and a list of recently shortened URLs.
///
/// {@category Features}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Shortener'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.about);
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppColors.error));
          } else if (state is HomeSuccess) {
            _urlController.clear();
            // FocusScope.of(context).unfocus();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildUrlInputSection(context, state),
              if (state is HomeLoading)
                const Padding(padding: EdgeInsets.all(AppSpacing.md), child: CircularProgressIndicator()),
              _buildUrlList(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUrlInputSection(BuildContext context, HomeState state) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'https://sou.nu',
                filled: true,
                fillColor: AppColors.neutral200,
                border: OutlineInputBorder(borderRadius: AppSizes.circularMd, borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              ),
              keyboardType: TextInputType.url,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            height: AppSizes.inputHeight,
            child: ElevatedButton(
              onPressed: state is HomeLoading
                  ? null
                  : () {
                      context.read<HomeCubit>().shortenUrl(_urlController.text);
                    },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: AppSizes.circularMd),
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrlList(HomeState state) {
    if (state is HomeSuccess) {
      if (state.shortenedUrls.isEmpty) {
        return const Expanded(child: Center(child: Text('No shortened URLs yet.')));
      }
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                child: Text('Recently shortened URLs', style: context.titleMedium),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: state.shortenedUrls.length,
                    itemBuilder: (context, index) {
                      return UrlListItem(index: index, urlAlias: state.shortenedUrls[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    // Mostra um estado vazio para HomeInitial e HomeError
    return Expanded(
      child: Center(child: Text('Enter a URL to see your history here!', style: context.bodyLarge)),
    );
  }
}
