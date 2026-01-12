import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gloss_bloom/l10n/app_localizations.dart';
import 'package:gloss_bloom/core/widgets/price_tag.dart';
import 'package:gloss_bloom/domain/entities/payment_info.dart';
import 'package:gloss_bloom/domain/entities/delivery_info.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _currentStep = 0;
  PaymentProvider? _selectedPaymentProvider;
  DeliveryProvider? _selectedDeliveryProvider;
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.checkout),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Stepper(
          currentStep: _currentStep,
          onStepTapped: (step) => setState(() => _currentStep = step),
          controlsBuilder: (context, details) => _buildStepControls(details),
          steps: [
            Step(
              title: const Text('Adresse de livraison'),
              content: _buildAddressStep(),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text('Mode de livraison'),
              content: _buildDeliveryStep(),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text('Paiement'),
              content: _buildPaymentStep(),
              isActive: _currentStep >= 2,
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildOrderSummary(l10n),
    );
  }

  Widget _buildAddressStep() {
    return Column(
      children: [
        TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Adresse complète',
            prefixIcon: Icon(Icons.location_on),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cityController,
          decoration: const InputDecoration(
            labelText: 'Ville',
            prefixIcon: Icon(Icons.location_city),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryStep() {
    final providers = [
      (DeliveryProvider.yobantel, 'Yobantel', '2-3 jours', '2500 FCFA'),
      (DeliveryProvider.colisExpress, 'ColisExpress', '1-2 jours', '3000 FCFA'),
      (DeliveryProvider.pickup, 'Retrait en boutique', 'Immédiat', 'Gratuit'),
    ];

    return Column(
      children: providers.map((provider) {
        return RadioListTile<DeliveryProvider>(
          value: provider.$1,
          groupValue: _selectedDeliveryProvider,
          onChanged: (value) => setState(() => _selectedDeliveryProvider = value),
          title: Text(provider.$2),
          subtitle: Text('${provider.$3} • ${provider.$4}'),
        );
      }).toList(),
    );
  }

  Widget _buildPaymentStep() {
    final providers = [
      (PaymentProvider.wave, 'Wave', Icons.payment),
      (PaymentProvider.orangeMoney, 'Orange Money', Icons.phone_android),
      (PaymentProvider.freeMoney, 'Free Money', Icons.account_balance_wallet),
      (PaymentProvider.payDunya, 'PayDunya', Icons.credit_card),
    ];

    return Column(
      children: providers.map((provider) {
        return RadioListTile<PaymentProvider>(
          value: provider.$1,
          groupValue: _selectedPaymentProvider,
          onChanged: (value) => setState(() => _selectedPaymentProvider = value),
          title: Text(provider.$2),
          secondary: Icon(provider.$3),
        );
      }).toList(),
    );
  }

  Widget _buildStepControls(ControlsDetails details) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          if (details.stepIndex > 0)
            OutlinedButton(
              onPressed: details.onStepCancel,
              child: const Text('Précédent'),
            ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: details.stepIndex < 2 ? details.onStepContinue : _processOrder,
            child: Text(details.stepIndex < 2 ? 'Suivant' : 'Confirmer'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sous-total', style: Theme.of(context).textTheme.bodyMedium),
              const PriceTag(price: 0),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Livraison', style: Theme.of(context).textTheme.bodyMedium),
              const Text('0 FCFA'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.cartTotal, style: Theme.of(context).textTheme.titleMedium),
              const PriceTag(price: 0),
            ],
          ),
        ],
      ),
    );
  }

  void _processOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Commande en cours de traitement...'),
        duration: Duration(seconds: 2),
      ),
    );
    
    // Navigate to order confirmation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Commande confirmée !')),
        );
      }
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}