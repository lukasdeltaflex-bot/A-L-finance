class AppConfig {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your-anon-key',
  );

  static bool get isConfigured => 
    supabaseUrl != 'https://your-project.supabase.co' && 
    supabaseAnonKey != 'your-anon-key';
}
