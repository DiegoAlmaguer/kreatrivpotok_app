# Kreativ Potok

Полный rewrite Flutter-приложения личного кабинета с role-based доступом и Supabase backend.

## Стек
- Flutter + Material 3
- GoRouter
- Supabase Flutter
- flutter_dotenv

## Архитектура
- `lib/core` — theme, routing, env/bootstrap, widgets, utils
- `lib/data` — models/repositories/services
- `lib/features` — auth/dashboard/projects/tasks/profile/admin/shell

## ENV
1. Скопируйте `.env.example` в `.env`
2. Заполните:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`

> Никогда не коммитьте `.env`.

## Запуск
```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

## Роли
- **client**: dashboard, projects, tasks(read-only scope by RLS), profile
- **staff**: dashboard, assigned projects/tasks, profile
- **admin**: dashboard, projects, users management, profile

Роль читается из `profiles.role`.

## Как создать пользователей и роли
1. Создать пользователя через экран регистрации или Supabase Auth.
2. В таблице `profiles` выставить поле `role` (`client|staff|admin`).
3. Для staff scope назначать проекты через поле `projects.staff_id`.

## DB schema
См. `docs/db_schema.md` (инференс по существующим запросам проекта).
