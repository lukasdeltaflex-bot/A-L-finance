/// Configurações centrais da aplicação A&L Finance.
/// URL e AnonKey reais do Supabase — não use placeholders aqui.
class AppConfig {
  // ─── Supabase ────────────────────────────────────────────────────────────
  static const String supabaseUrl =
      'https://qotnldhejojuusheutc.supabase.co';

  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
      '.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFvdG5sZGhlam9qdXVzaGVhdXRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg1NjE4NzYsImV4cCI6MjA5NDEzNzg3Nn0'
      '.iAKgWcXFxw_So4gfAVvBEW7MwDLOEcCdqOEBLQcMY9c';

  // ─── Validação ───────────────────────────────────────────────────────────
  /// Retorna true quando as credenciais reais estão presentes.
  static bool get isConfigured =>
      supabaseUrl.startsWith('https://') &&
      !supabaseUrl.contains('your-project') &&
      supabaseAnonKey.length > 50;

  // ─── Deep-link / Auth redirect ───────────────────────────────────────────
  /// URI de redirecionamento para OAuth e recuperação de senha (web).
  static const String authRedirectUrl =
      'https://qotnldhejojuusheutc.supabase.co/auth/v1/callback';

  /// Scheme para deep-link em mobile (Android / iOS).
  static const String deepLinkScheme = 'alfinance';
  static const String deepLinkHost = 'auth-callback';
}
