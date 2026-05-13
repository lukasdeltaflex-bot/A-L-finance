import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';

/// Serviço central de autenticação para o A&L Finance.
///
/// Encapsula todas as operações do Supabase Auth com:
/// - tratamento de erros amigável (PT-BR)
/// - logs claros em modo debug
/// - fallback para falhas de rede
class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ─── Stream / Estado ──────────────────────────────────────────────────────

  /// Emite eventos de autenticação (login, logout, refresh de token…).
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Usuário autenticado no momento (null se não autenticado).
  User? get currentUser => _supabase.auth.currentUser;

  /// Sessão ativa (inclui access_token e refresh_token).
  Session? get currentSession => _supabase.auth.currentSession;

  /// Retorna true se há um usuário autenticado com sessão válida.
  bool get isAuthenticated => currentUser != null;

  // ─── Cadastro ─────────────────────────────────────────────────────────────

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    _log('signUp → $email');
    try {
      final response = await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'full_name': fullName.trim(),
          'display_name': fullName.trim().split(' ').first,
        },
        emailRedirectTo: kIsWeb ? null : '${AppConfig.deepLinkScheme}://${AppConfig.deepLinkHost}',
      );
      _log('signUp OK → userId=${response.user?.id}');
      return response;
    } on AuthException catch (e) {
      _logError('signUp', e.message);
      throw _mapAuthError(e);
    } catch (e) {
      _logError('signUp', e.toString());
      throw _networkError();
    }
  }

  // ─── Login ────────────────────────────────────────────────────────────────

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    _log('signIn → $email');
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      _log('signIn OK → userId=${response.user?.id}');
      return response;
    } on AuthException catch (e) {
      _logError('signIn', e.message);
      throw _mapAuthError(e);
    } catch (e) {
      _logError('signIn', e.toString());
      throw _networkError();
    }
  }

  // ─── Google Sign-In ───────────────────────────────────────────────────────

  /// Login com Google via OAuth (browser redirect).
  /// Funciona em Web e Mobile com deep-link configurado.
  Future<void> signInWithGoogle() async {
    _log('signInWithGoogle → iniciando OAuth');
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb
            ? AppConfig.authRedirectUrl
            : '${AppConfig.deepLinkScheme}://${AppConfig.deepLinkHost}',
        authScreenLaunchMode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
      );
    } on AuthException catch (e) {
      _logError('signInWithGoogle', e.message);
      throw _mapAuthError(e);
    } catch (e) {
      _logError('signInWithGoogle', e.toString());
      throw Exception(
        'Não foi possível iniciar o login com Google. Verifique sua conexão e tente novamente.',
      );
    }
  }

  // ─── Logout ───────────────────────────────────────────────────────────────

  Future<void> signOut() async {
    _log('signOut');
    try {
      await _supabase.auth.signOut();
      _log('signOut OK');
    } on AuthException catch (e) {
      _logError('signOut', e.message);
      // logout silencioso — limpa localmente mesmo se falhar no servidor
    } catch (e) {
      _logError('signOut (unexpected)', e.toString());
    }
  }

  // ─── Recuperação de senha ─────────────────────────────────────────────────

  Future<void> sendPasswordResetEmail(String email) async {
    _log('resetPassword → $email');
    try {
      await _supabase.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: kIsWeb
            ? AppConfig.authRedirectUrl
            : '${AppConfig.deepLinkScheme}://${AppConfig.deepLinkHost}',
      );
      _log('resetPassword OK');
    } on AuthException catch (e) {
      _logError('resetPassword', e.message);
      throw _mapAuthError(e);
    } catch (e) {
      _logError('resetPassword', e.toString());
      throw _networkError();
    }
  }

  // ─── Atualização de senha (após reset) ───────────────────────────────────

  Future<UserResponse> updatePassword(String newPassword) async {
    _log('updatePassword');
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      _log('updatePassword OK');
      return response;
    } on AuthException catch (e) {
      _logError('updatePassword', e.message);
      throw _mapAuthError(e);
    } catch (e) {
      _logError('updatePassword', e.toString());
      throw _networkError();
    }
  }

  // ─── Refresh de sessão ────────────────────────────────────────────────────

  Future<void> refreshSession() async {
    try {
      await _supabase.auth.refreshSession();
      _log('refreshSession OK');
    } catch (e) {
      _logError('refreshSession', e.toString());
    }
  }

  // ─── Helpers privados ─────────────────────────────────────────────────────

  /// Mapeia erros do Supabase Auth para mensagens amigáveis em português.
  Exception _mapAuthError(AuthException e) {
    final msg = e.message.toLowerCase();

    if (msg.contains('invalid login credentials') ||
        msg.contains('invalid credentials') ||
        msg.contains('wrong password')) {
      return Exception('E-mail ou senha incorretos. Tente novamente.');
    }

    if (msg.contains('email not confirmed')) {
      return Exception(
        'Confirme seu e-mail antes de entrar. Verifique sua caixa de entrada.',
      );
    }

    if (msg.contains('user already registered') ||
        msg.contains('already been registered')) {
      return Exception(
        'Este e-mail já está cadastrado. Faça login ou recupere sua senha.',
      );
    }

    if (msg.contains('password') && msg.contains('characters')) {
      return Exception('A senha deve ter pelo menos 6 caracteres.');
    }

    if (msg.contains('rate limit') || msg.contains('too many requests')) {
      return Exception(
        'Muitas tentativas. Aguarde alguns minutos e tente novamente.',
      );
    }

    if (msg.contains('network') || msg.contains('fetch')) {
      return _networkError();
    }

    // fallback — retorna a mensagem original traduzida
    return Exception('Erro de autenticação: ${e.message}');
  }

  Exception _networkError() => Exception(
        'Não foi possível conectar ao servidor. '
        'Verifique sua conexão com a internet e tente novamente.',
      );

  void _log(String msg) =>
      dev.log('[AuthService] $msg', name: 'ALFinance');

  void _logError(String op, String err) =>
      dev.log('[AuthService] ERRO em $op: $err', name: 'ALFinance', level: 1000);
}
