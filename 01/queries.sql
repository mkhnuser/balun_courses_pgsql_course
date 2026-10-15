-- Домашнее задание 1. Запишите здесь свои запросы.
-- Выполняйте команды отдельно, без общего BEGIN/COMMIT.

-- 1. Все регистрации: email, код курса, статус.
--    Упорядочить по email и коду курса.

select u.email, c.code, e.status from enrollments e left join users u on e.user_id = u.id left join courses c on e.course_id = c.id order by u.email, c.code;

-- 2. Оплаченные регистрации: email и код курса.
select u.email, c.code from enrollments e left join users u on e.user_id = u.id left join courses c on e.course_id = c.id where e.status = 'paid' order by u.email, c.code;

-- 3. Пользователи без регистраций: email.

select u.email, e.id from users u full join enrollments e on u.id = e.user_id where e.id is NULL;

-- 4. Попытка повторно зарегистрировать Анну на postgres-dev.


INSERT INTO enrollments(user_id, course_id, amount_cents, status)
SELECT u.id, c.id, 150000, 'paid'
FROM users AS u
CROSS JOIN courses AS c
WHERE u.email = 'anna@example.test'
  AND c.code = 'postgres-dev';

-- 5. Попытка зарегистрировать отсутствующего пользователя с ID -1.


INSERT INTO enrollments(user_id, course_id, amount_cents, status)
SELECT -1, c.id, 150000, 'pending'
FROM courses AS c
WHERE c.code = 'postgres-dev';


-- 6. Попытка зарегистрировать Веру на sql-basics с суммой -100.

INSERT INTO enrollments(user_id, course_id, amount_cents, status)
SELECT u.id, c.id, -100, 'pending'
FROM users AS u
CROSS JOIN courses AS c
WHERE u.email = 'vera@example.test'
  AND c.code = 'sql-basics';

