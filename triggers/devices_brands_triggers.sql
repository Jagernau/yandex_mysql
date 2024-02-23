---------------Создание ТРИГГЕРОВ----------------------------
-----Тригер Обновления таблицы devices_brands
DELIMITER $$
CREATE TRIGGER log_triger_devices_brands_updates
AFTER UPDATE ON devices_brands
FOR EACH ROW
BEGIN
    IF NEW.name <> OLD.name THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'devices_brands',
                2,
                OLD.id, 
                'name', 
                OLD.name, 
                NEW.name
            );
    END IF;
    If NEW.devices_vendor_id <> OLD.devices_vendor_id THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'devices_brands',
                2, 
                OLD.id, 
                'devices_vendor_id', 
                OLD.devices_vendor_id, 
                NEW.devices_vendor_id
            );
    END IF;
END$$
DELIMITER ;

-----Тригер удаления в таблице devices_brands
DELIMITER //
CREATE TRIGGER log_triger_devices_brands_deletes
AFTER DELETE 
ON devices_brands
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val) 
    VALUES ('devices_brands', 0, OLD.id, 'all', OLD.name, 'none')//
DELIMITER ;

-----Тригер добавления в таблице devices_brands
DELIMITER //
CREATE TRIGGER log_triger_devices_brands_inserts
AFTER INSERT 
ON devices_brands
FOR EACH ROW
Insert into 
    log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val)
    VALUES ('devices_brands', 1, NEW.id, 'all', 'none', NEW.name)//
DELIMITER ;

