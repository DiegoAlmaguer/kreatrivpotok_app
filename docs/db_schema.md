# DB schema (inferred from existing codebase)

> Источник: анализ существующих Supabase-запросов в `lib/features/**` и `lib/features/auth/**`.
> В репозитории не найдено SQL-миграций, поэтому ниже — **инференс по коду**.

## Roles
- `client`
- `staff`
- `admin`

Роль читается из таблицы `profiles.role` и влияет на доступ к экранам.

## Tables

### `profiles`
Использование:
- Поиск роли пользователя по `id`.

Поля (обнаруженные):
- `id` (uuid, совпадает с auth user id)
- `role` (text: `client|staff|admin`)
- вероятно: `full_name`, `created_at`, `updated_at` (не были явно использованы, но ожидаемы для профиля)

Связи:
- `profiles.id` -> `auth.users.id`

### `projects`
Использование:
- Список и карточка проекта.
- Обновление `status`.

Поля (обнаруженные):
- `id`
- `title`
- `description`
- `status` (`new|in_progress|done|canceled`)
- `created_at`
- `client_id`
- возможно: `staff_id`/`manager_id` (логически требуется для staff scope, но явно не использовалось)

Связи:
- `projects.client_id` -> `profiles.id`
- вероятно `projects.staff_id` -> `profiles.id`

### `payments`
Использование:
- Список оплат по проекту.
- Вставка оплаты staff/admin.

Поля (обнаруженные):
- `id` (предположительно)
- `project_id`
- `amount`
- `status` (например `pending`)
- `title` (опционально)
- `created_at`

Связи:
- `payments.project_id` -> `projects.id`

### `documents` / `project_documents`
В старом коде встречаются обе таблицы:
- `documents` (staff/admin)
- `project_documents` (client)

Поля (обнаруженные):
- `id` (предположительно)
- `project_id`
- `title` / `name`
- `url` / `file_url`
- `path` / `file_path` (storage path)
- `created_at`

Связи:
- `documents.project_id` -> `projects.id`
- `project_documents.project_id` -> `projects.id`

## Storage
- Используется bucket для документов проекта (в старом коде: `project_docs`, в конфиге встречался `client-docs`).
- Для production рекомендуется единая naming policy и RLS/storage policy на уровень `client_id/project_id`.

## Индексы (рекомендации)
- `projects(client_id)`
- `projects(staff_id)` (если поле есть)
- `payments(project_id, created_at desc)`
- `documents(project_id, created_at desc)`
