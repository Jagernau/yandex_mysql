---------------Создание ТРИГГЕРОВ----------------------------
-----Тригер Обновления таблицы devices_vendor
DELIMITER $$
CREATE TRIGGER log_triger_devices_vendor_updates
AFTER UPDATE ON devices_vendor
FOR EACH ROW
BEGIN
    IF NEW.vendor_name <> OLD.vendor_name THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'devices_vendor',
                2,
                OLD.id, 
                'vendor_name', 
                OLD.vendor_name, 
                NEW.vendor_name
            );
    END IF;
END$$
DELIMITER ;

-----Тригер удаления в таблице devices_vendor
DELIMITER //
CREATE TRIGGER log_triger_devices_vendor_deletes
AFTER DELETE 
ON devices_vendor
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val) 
    VALUES ('devices_vendor', 0, OLD.id, 'all', OLD.vendor_name, 'none')//
DELIMITER ;

-----Тригер добавления в таблице devices_vendor
DELIMITER //
CREATE TRIGGER log_triger_devices_vendor_inserts
AFTER INSERT 
ON devices_vendor
FOR EACH ROW
Insert into 
    log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val)
    VALUES ('devices_vendor', 1, NEW.id, 'all', 'none', NEW.vendor_name)//
DELIMITER ;

