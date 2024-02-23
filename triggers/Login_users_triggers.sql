---------------Создание ТРИГГЕРОВ----------------------------
-----Тригер Обновления таблицы Login_users
DELIMITER $$
CREATE TRIGGER log_triger_Login_users_updates
AFTER UPDATE ON Login_users
FOR EACH ROW
BEGIN
    IF NEW.login <> OLD.login THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'Login_users',
                2,
                OLD.id, 
                'login', 
                OLD.login, 
                NEW.login
            );
    END IF;
    If NEW.email <> OLD.email THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'Login_users',
                2, 
                OLD.id, 
                'email', 
                OLD.email, 
                NEW.email
            );
    END IF;
    If NEW.password <> OLD.password THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'Login_users',
                2,
                OLD.id,
                'password',
                OLD.password,
                NEW.password
            );
    END IF;

    If NEW.system_id <> OLD.system_id THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'Login_users',
                2,
                OLD.id,
                'system_id',
                OLD.system_id,
                NEW.system_id
            );
    END IF;


    If NEW.contragent_id <> OLD.contragent_id THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'Login_users',
                2,
                OLD.id,
                'contragent_id',
                OLD.contragent_id,
                NEW.contragent_id
            );
    END IF;


    If NEW.account_status <> OLD.account_status THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'Login_users',
                2,
                OLD.id,
                'account_status',
                OLD.account_status,
                NEW.account_status
            );
    END IF;

END$$
DELIMITER ;

-----Тригер удаления в таблице Login_users
DELIMITER //
CREATE TRIGGER log_triger_Login_users_deletes
AFTER DELETE 
ON Login_users
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val) 
    VALUES ('Login_users', 0, OLD.id, 'all', OLD.login, 'none')//
DELIMITER ;

-----Тригер добавления в таблице Login_users
DELIMITER //
CREATE TRIGGER log_triger_Login_users_inserts
AFTER INSERT 
ON Login_users
FOR EACH ROW
Insert into 
    log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val)
    VALUES ('Login_users', 1, NEW.id, 'all', 'none', NEW.login)//
DELIMITER ;

