---------------Создание ТРИГГЕРОВ----------------------------
-----Тригер Обновления таблицы devices
DELIMITER $$
CREATE TRIGGER log_triger_device_updates
AFTER UPDATE ON devices
FOR EACH ROW
BEGIN
    IF NEW.sys_mon_id <> OLD.sys_mon_id THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'devices',
                2,
                OLD.device_id, 
                'sys_mon_id', 
                OLD.sys_mon_id, 
                NEW.sys_mon_id
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
                'devices',
                2, 
                OLD.device_id, 
                'contragent_id', 
                OLD.contragent_id, 
                NEW.contragent_id
            );
    END IF;
    If NEW.itprogrammer_id <> OLD.itprogrammer_id THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'devices',
                2,
                OLD.device_id,
                'itprogrammer_id',
                OLD.itprogrammer_id,
                NEW.itprogrammer_id
            );
    END IF;
END$$
DELIMITER ;

-----Тригер удаления в таблице devices
DELIMITER //
CREATE TRIGGER log_triger_device_deletes
AFTER DELETE 
ON devices
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val) 
    VALUES ('devices', 0, OLD.device_id, 'all', OLD.device_serial, 'none')//
DELIMITER ;

-----Тригер добавления в таблице devices
DELIMITER //
CREATE TRIGGER log_triger_device_inserts
AFTER INSERT 
ON devices
FOR EACH ROW
Insert into 
    log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val)
    VALUES ('devices', 1, NEW.device_id, 'all', 'none', NEW.device_serial)//
DELIMITER ;

