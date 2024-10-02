import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:particle_base/particle_base.dart';
import 'package:particle_auth_core/particle_auth_core.dart';
import 'package:particle_connect/model/connect_kit_config.dart';
import 'package:particle_connect/particle_connect.dart';
import 'package:trustfund_app/screen/bottom_nav.dart';
import 'package:trustfund_app/screen/signup_login_screen.dart';

class ConnectLogicProvider extends ChangeNotifier {
  bool _closeConnectWithWalletPage = false;

  List<Account> _connectedAccounts = [];

  late Map<String, dynamic> _tokens;

  bool get closeConnectWithWalletPage => _closeConnectWithWalletPage;

  List<Account> get connectedAccounts => _connectedAccounts;

  Map<String, dynamic> get tokens => _tokens;

  set closeConnectWithWalletPage(bool newValue) {
    if (_closeConnectWithWalletPage != newValue) {
      _closeConnectWithWalletPage = newValue;
      notifyListeners();
    }
  }

  ChainInfo _currChainInfo = ChainInfo.BaseSepolia;

  ChainInfo get currChainInfo => _currChainInfo;

  set currChainInfo(ChainInfo newValue) {
    if (_currChainInfo != newValue) {
      _currChainInfo = newValue;
      notifyListeners();
    }
  }

  void init() {
    ParticleInfo.set(
        dotenv.env['PN_PROJECT_ID']!, dotenv.env['PN_PROJECT_CLIENT_KEY']!);

    ParticleBase.setAppearance(Appearance.light);

    final dappInfo = DappMetaData(
      "trustfund",
      "https://trustfund.info/images/favicon.png",
      "https://trustfund.xyz",
      "Your Future Trust Savings",
      redirect: 'https://www.trustfund.xyz',
    );

    ParticleConnect.init(currChainInfo, dappInfo, Env.dev);
    ParticleAuthCore.init();

    // List<ChainInfo> chainInfos = <ChainInfo>[
    //   ChainInfo.Ethereum,
    //   ChainInfo.Polygon
    // ];
    // List<ChainInfo> chainInfos = <ChainInfo>[currChainInfo];

    //metamask only supported one chain
    // ParticleConnect.setWalletConnectV2SupportChainInfos(chainInfos);
  }

  void connectWithConnectKit() async {
    final config = ConnectKitConfig(
      logo: "assets/images/hori_logo.png",
      //base64 or https
      connectOptions: [
        //   ConnectOption.SOCIAL,
        ConnectOption.EMAIL,
        ConnectOption.PHONE,
        ConnectOption.WALLET,
      ], // Changing the order can affect the interface
      socialProviders: [
        EnableSocialProvider.GOOGLE,
        EnableSocialProvider.FACEBOOK,
        EnableSocialProvider.TWITTER,
        // EnableSocialProvider.APPLE,
        EnableSocialProvider.DISCORD,
        EnableSocialProvider.GITHUB,
        EnableSocialProvider.MICROSOFT,
        EnableSocialProvider.LINKEDIN,
        EnableSocialProvider.TWITCH,
      ], // Changing the order can affect the interface
      //Changing the order can affect the interface
      walletProviders: [
        EnableWalletProvider(EnableWallet.MetaMask,
            label: EnableWalletLabel.RECOMMENDED),
        EnableWalletProvider(EnableWallet.Trust,
            label: EnableWalletLabel.POPULAR),
        EnableWalletProvider(EnableWallet.Bitget,
            label: EnableWalletLabel.POPULAR),
        EnableWalletProvider(EnableWallet.Rainbow),
        EnableWalletProvider(EnableWallet.OKX),
        EnableWalletProvider(EnableWallet.ImToken),
        // EnableWalletProvider(EnableWallet.WalletConnect),
      ],
      //Changing the order can affect the interface
      additionalLayoutOptions: AdditionalLayoutOptions(
        isCollapseWalletList: false,
        isSplitEmailAndSocial: false,
        isSplitEmailAndPhone: false,
        isHideContinueButton: false,
      ),
    );

    try {
      await ParticleConnect.connectWithConnectKitConfig(config);
      refreshConnectedAccounts().then((value) => const BottomNav());
      closeConnectWithWalletPage = true;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> refreshConnectedAccounts() async {
    List<Account> connectedAccounts = <Account>[];
    try {
      for (WalletType walletType in WalletType.values) {
        ChainInfo chainInfo = await ParticleBase.getChainInfo();
        final accounts = await ParticleConnect.getAccounts(walletType);

        if (chainInfo.isEvmChain()) {
          final evmAccounts = accounts
              .where((account) => account.publicAddress.startsWith("0x"));
          connectedAccounts.addAll(evmAccounts);
        } else {
          final solanaAccounts = accounts
              .where((account) => !account.publicAddress.startsWith("0x"));
          connectedAccounts.addAll(solanaAccounts);
        }
      }
    } catch (error) {
      // print("getConnectedAccounts: $error");
    }
    _connectedAccounts = connectedAccounts;
    notifyListeners();
  }

  Future<void> getTokens() async {
    try {
      final address = connectedAccounts.first.publicAddress;
      var result = await EvmService.getTokens(address, []);
      _tokens = result;
    } catch (error) {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  void disconnect(WalletType walletType, String publicAddress) async {
    try {
      await ParticleConnect.disconnect(walletType, publicAddress)
          .then((value) => const SignupLoginScreen());
      refreshConnectedAccounts();
    } catch (error) {
      throw Exception(error);
    }
  }
}
