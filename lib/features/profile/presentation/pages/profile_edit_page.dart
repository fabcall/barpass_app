import 'dart:io';

import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/profile/presentation/providers/profile_edit_provider.dart';
import 'package:barpass_app/features/profile/presentation/state/profile_edit_state.dart';
import 'package:barpass_app/features/profile/presentation/widgets/gender_selection_sheet.dart';
import 'package:barpass_app/features/user/presentation/providers/user_provider.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/avatar.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:barpass_app/shared/widgets/utilities/keyboard_dismiss_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String? _localAvatarPath;
  Gender? _selectedGender;
  final _isFormValid = ValueNotifier<bool>(false);
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();

    // Usa currentUserProvider ao invés de authProvider
    final user = ref.read(currentUserProvider);
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    _selectedGender = user?.gender;

    _nameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _phoneController.removeListener(_validateForm);
    _nameController.dispose();
    _phoneController.dispose();
    _isFormValid.dispose();
    super.dispose();
  }

  void _validateForm() {
    final name = _nameController.text.trim();
    _isFormValid.value =
        name.isNotEmpty && (_formKey.currentState?.validate() ?? false);
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    String? avatarUrl;

    // Se tem uma imagem local nova, faz o upload primeiro
    if (_localAvatarPath != null) {
      setState(() => _isUploadingImage = true);
      try {} on Exception catch (_) {
        if (mounted) {
          Burnt().toast(
            context,
            title: 'Erro ao fazer upload da imagem',
            preset: BurntPreset.error,
          );
        }
        setState(() => _isUploadingImage = false);
        return;
      }
      setState(() => _isUploadingImage = false);
    }

    await ref
        .read(profileEditProvider.notifier)
        .updateProfile(
          name: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim().isEmpty
              ? null
              : _phoneController.text.trim(),
          avatarUrl: avatarUrl,
          gender: _selectedGender,
        );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _localAvatarPath = image.path;
      });
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tirar foto'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolher da galeria'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Usa currentUserProvider ao invés de authProvider
    final user = ref.watch(currentUserProvider);

    // Escuta mudanças no estado de edição
    ref.listen(profileEditProvider, (previous, next) {
      switch (next) {
        case ProfileEditSuccess():
          Burnt().toast(
            context,
            title: 'Perfil atualizado com sucesso!',
            preset: BurntPreset.done,
          );
          Navigator.of(context).pop();
        case ProfileEditError(:final message):
          Burnt().toast(
            context,
            title: message,
            preset: BurntPreset.error,
          );
        default:
          break;
      }
    });

    final editState = ref.watch(profileEditProvider);
    final isLoading = editState is ProfileEditLoading || _isUploadingImage;

    return SheetContentScaffold(
      topBar: AppBar(
        centerTitle: true,
        title: const Text('Editar Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
        ),
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: ValueListenableBuilder<bool>(
        valueListenable: _isFormValid,
        builder: (context, isValid, child) {
          return FloatingActionBar(
            child: FilledButton(
              onPressed: isLoading || !isValid ? null : _handleSave,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Salvar Alterações'),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar
              Center(
                child: Stack(
                  children: [
                    Avatar(
                      size: AppSizes.avatarXxl,
                      backgroundColor: context.colorScheme.primaryContainer,
                      image: _localAvatarPath != null
                          ? FileImage(File(_localAvatarPath!))
                          : user?.avatarUrl != null
                          ? NetworkImage(user!.avatarUrl!)
                          : null,
                      child: _localAvatarPath == null && user?.avatarUrl == null
                          ? Icon(
                              Icons.person,
                              size: 60,
                              color: context.colorScheme.onPrimaryContainer,
                            )
                          : null,
                    ),
                    if (_isUploadingImage)
                      Positioned.fill(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.black54,
                          child: CircularProgressIndicator(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: isLoading ? null : _showImageSourceSheet,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: context.colorScheme.primary,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(32),

              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome'),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome não pode estar vazio';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),

              const Gap(16),

              TextFormField(
                decoration: InputDecoration(
                  label: const Text('E-mail'),
                  prefixIcon: const Icon(Icons.email_outlined),
                  enabled: false,
                  suffixIcon: user?.isEmailVerified ?? false
                      ? Icon(
                          Icons.verified,
                          color: context.colorScheme.primary,
                        )
                      : null,
                ),
                initialValue: user?.email ?? '',
              ),

              const Gap(16),

              TextFormField(
                decoration: InputDecoration(
                  label: const Text('Telefone (opcional)'),
                  prefixIcon: const Icon(Icons.phone_outlined),
                  suffixIcon: user?.isPhoneVerified ?? false
                      ? Icon(
                          Icons.verified,
                          color: context.colorScheme.primary,
                        )
                      : null,
                ),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),

              const Gap(16),

              ListTile(
                dense: true,
                onTap: isLoading
                    ? null
                    : () async {
                        final selectedGender = await showGenderSelectionSheet(
                          context,
                          initialSelection: _selectedGender,
                        );
                        if (selectedGender != null) {
                          setState(() {
                            _selectedGender = selectedGender;
                          });
                          _validateForm();
                        }
                      },
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                leading: Icon(
                  Icons.transgender,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                title: Text(
                  'Gênero',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                subtitle: Text(
                  _selectedGender == Gender.female
                      ? 'Feminino'
                      : _selectedGender == Gender.male
                      ? 'Masculino'
                      : 'Prefiro não responder',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const Gap(24),

              // Informações adicionais
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: context.colorScheme.primary,
                        ),
                        const Gap(8),
                        Text(
                          'Informações da conta',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    _InfoRow(
                      label: 'Membro desde',
                      value: user?.createdAt != null
                          ? _formatDate(user!.createdAt!)
                          : 'Não disponível',
                    ),
                    if (user?.lastLoginAt != null) ...[
                      const Gap(8),
                      _InfoRow(
                        label: 'Último acesso',
                        value: _formatDate(user!.lastLoginAt!),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).dismissKeyboard();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoje';
    } else if (difference.inDays == 1) {
      return 'Ontem';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? "mês" : "meses"} atrás';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? "ano" : "anos"} atrás';
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
