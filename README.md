# Описание проекта  
Данный репозиторий содержит набор SQL-скриптов для решения учебных задач по базам данных (PostgreSQL). Проект включает четыре отдельные группы заданий: HW_DB_1, HW_DB_2, HW_DB_3, HW_DB_4, в каждую группу включен набор скриптов для создания, наполнения и обработки данных.  

1. **Описание проекта**  
Цель: Практика написания SQL-запросов, создания и наполнения таблиц, а также реализации отдельных операций в рамках учебных заданий.  
СУБД: Проект рассчитан на использование PostgreSQL (рекомендуемая версия — 12 и выше). Работа выполнялась на версии PostgreSQL 17.4 on x86_64-windows, compiled by msvc-19.42.34436, 64-bit.  
Состав: В каждой группе содержится один файл со скриптом для создания и наполнения базы (DB_X_Initialisation.sql) и несколько файлов с решениями заданий (DB_X_Task_N.sql).  

2. **Структура проекта**  
Описание содержимого папок (групп):
HW_DB_1  
    DB_1_Initialisation.sql – скрипт создания и наполнения первой базы данных.  
    DB_1_Task_1.sql, DB_1_Task_2.sql – SQL-скрипты с решениями задач.  
HW_DB_2  
    DB_2_Initialisation.sql – скрипт создания и наполнения второй базы данных.  
    DB_2_Task_1.sql ... DB_2_Task_5.sql – SQL-скрипты с решениями пяти отдельных задач.  
HW_DB_3  
    DB_3_Initialisation.sql – скрипт создания и наполнения третьей базы данных.  
    DB_3_Task_1.sql, DB_3_Task_2.sql, DB_3_Task_3.sql – SQL-скрипты с решениями.  
HW_DB_4  
    DB_4_Initialisation.sql – скрипт создания и наполнения четвёртой базы данных.  
    DB_4_Task_1.sql, DB_4_Task_2.sql, DB_4_Task_3.sql – SQL-скрипты с решениями.  

3. **Инструкция по запуску**  
3.1. ***Создайте базу данных (если ещё не создана):***  
``
CREATE DATABASE <название БД>;  
``  
3.2. ***Подключитесь к созданной базе данных.***  
``
psql -U postgres -d <название БД>;  
``  
3.3. ***Выполните скрипт DB_X_Initialisation.sql (например, DB_1_Initialisation.sql) для создания и наполнения таблиц.***  
3.4 ***Запустите SQL-скрипты с решениями задач (например, DB_1_Task_1.sql и последующие).***  
3.5. ***Проверьте результат выполнения скрипта с ожидаемым результатом из задания.***   
В случае несовпадения результатов:  
    Убедитесь, что все таблицы и данные созданы правильно.  
    Запросы выполняются корректно и возвращают ожидаемые результаты.  
> В задаче #5 (Автомобильные гонки) результрующая таблица не совпадает с ожидаемой. Читай описание.  

4. ***Дополнительная информация***  
Все скрипты не создают базу данных автоматически — её нужно создать вручную.  
Скрипты DB_X_Initialisation.sql содержат код для создания и наполнения таблиц, но не создают саму базу данных.  
Порядок выполнения важен: сначала DB_X_Initialisation.sql, затем DB_X_Task_N.sql.  
