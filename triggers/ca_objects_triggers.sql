---------------Создание ТРИГГЕРОВ----------------------------
-----Тригер Обновления таблицы ca_objects
DELIMITER $$
CREATE TRIGGER log_triger_ca_objects_updates
AFTER UPDATE ON ca_objects
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
                'ca_objects',
                2,
                OLD.id, 
                'sys_mon_id', 
                OLD.sys_mon_id, 
                NEW.sys_mon_id
            );
    END IF;
    IF NEW.sys_mon_object_id <> OLD.sys_mon_object_id THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'sys_mon_object_id', 
                OLD.sys_mon_object_id, 
                NEW.sys_mon_object_id
            );
    END IF;
    IF NEW.object_name <> OLD.object_name THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'object_name', 
                OLD.object_name, 
                NEW.object_name
            );
    END IF;
    IF NEW.object_status <> OLD.object_status THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'object_status', 
                OLD.object_status, 
                NEW.object_status
            );
    END IF;
    IF NEW.object_margin <> OLD.object_margin THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'object_margin', 
                OLD.object_margin, 
                NEW.object_margin
            );
    END IF;
    IF NEW.owner_contragent <> OLD.owner_contragent THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'owner_contragent', 
                OLD.owner_contragent, 
                NEW.owner_contragent
            );
    END IF;
    IF NEW.owner_user <> OLD.owner_user THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'owner_user', 
                OLD.owner_user, 
                NEW.owner_user
            );
    END IF;
    IF NEW.imei <> OLD.imei THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'imei', 
                OLD.imei, 
                NEW.imei
            );
    END IF;
    IF NEW.parent_id_sys <> OLD.parent_id_sys THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'parent_id_sys',
                OLD.parent_id_sys,
                NEW.parent_id_sys
            );
    END IF;
    IF NEW.contragent_id <> OLD.contragent_id THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'ca_objects',
                2,
                OLD.id, 
                'contragent_id',
                OLD.contragent_id,
                NEW.contragent_id
            );
    END IF;
END$$
DELIMITER ;

-----Тригер удаления в таблице ca_objects
DELIMITER //
CREATE TRIGGER log_triger_ca_objects_deletes
AFTER DELETE 
ON ca_objects
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val) 
    VALUES ('ca_objects', 0, OLD.id, 'all', OLD.object_name, 'none')//
DELIMITER ;

-----Тригер добавления в таблице ca_objects
DELIMITER //
CREATE TRIGGER log_triger_ca_objects_inserts
AFTER INSERT 
ON ca_objects
FOR EACH ROW
Insert into 
    log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val)
    VALUES ('ca_objects', 1, NEW.id, 'all', 'none', NEW.object_name)//
DELIMITER ;

-----Тригер вытаскивания госномера при insert и updateпо типу А123БВ12  ca_objects и пемещение в таблицу object_vehicles

DELIMITER $$
CREATE TRIGGER trg_insert_ca_objects_gos_nomer_1
AFTER INSERT ON ca_objects
FOR EACH ROW
BEGIN
    IF NEW.object_name REGEXP '.*[A-Za-zА-Яа-я][0-9]{3}[A-Za-zА-Яа-я]{2}[0-9]{2}.*'
        AND NEW.contragent_id IS NOT NULL 
        AND NOT EXISTS (
            SELECT vehicle_gos_nomer FROM object_vehicles
            WHERE UPPER(vehicle_gos_nomer) = UPPER(REGEXP_SUBSTR(NEW.object_name, '[A-Za-zА-Яа-я][0-9]{3}[A-Za-zА-Яа-я]{2}[0-9]{2}')))
    THEN
        INSERT IGNORE INTO object_vehicles(vehicle_gos_nomer, vehicle_ca_id) 
        VALUES (UPPER(REGEXP_SUBSTR(NEW.object_name, '[A-Za-zА-Яа-я][0-9]{3}[A-Za-zА-Яа-я]{2}[0-9]{2}')), NEW.contragent_id);
    END IF;
END$$
DELIMITER ;



-----Тригер вытаскивания госномера при insert и updateпо типу А123БВ123  ca_objects и пемещение в таблицу object_vehicles

DELIMITER $$
CREATE TRIGGER trg_insert_ca_objects_gos_nomer_2
AFTER INSERT ON ca_objects
FOR EACH ROW
BEGIN
    IF NEW.object_name REGEXP '.*[A-Za-zА-Яа-я][0-9]{3}[A-Za-zА-Яа-я]{2}[0-9]{3}.*'
        AND NEW.contragent_id IS NOT NULL 
        AND NOT EXISTS (
            SELECT vehicle_gos_nomer FROM object_vehicles
            WHERE UPPER(vehicle_gos_nomer) = UPPER(REGEXP_SUBSTR(NEW.object_name, '[A-Za-zА-Яа-я][0-9]{3}[A-Za-zА-Яа-я]{2}[0-9]{3}')))
    THEN
        INSERT IGNORE INTO object_vehicles(vehicle_gos_nomer, vehicle_ca_id) 
        VALUES (UPPER(REGEXP_SUBSTR(NEW.object_name, '[A-Za-zА-Яа-я][0-9]{3}[A-Za-zА-Яа-я]{2}[0-9]{3}')), NEW.contragent_id);
    END IF;
END$$
DELIMITER ;



-----Тригер вытаскивания госномера при insert и updateпо типу 1234БВ123  ca_objects и пемещение в таблицу object_vehicles

DELIMITER $$
CREATE TRIGGER trg_insert_ca_objects_gos_nomer_3
AFTER INSERT ON ca_objects
FOR EACH ROW
BEGIN
    IF NEW.object_name REGEXP '.*[0-9]{4}[A-Za-zА-Яа-я]{2}[0-9]{3}.*'
        AND NEW.contragent_id IS NOT NULL 
        AND NOT EXISTS (
            SELECT vehicle_gos_nomer FROM object_vehicles
            WHERE UPPER(vehicle_gos_nomer) = UPPER(REGEXP_SUBSTR(NEW.object_name, '[0-9]{4}[A-Za-zА-Яа-я]{2}[0-9]{3}')))
    THEN
        INSERT IGNORE INTO object_vehicles(vehicle_gos_nomer, vehicle_ca_id) 
        VALUES (UPPER(REGEXP_SUBSTR(NEW.object_name, '[0-9]{4}[A-Za-zА-Яа-я]{2}[0-9]{3}')), NEW.contragent_id);
    END IF;
END$$
DELIMITER ;


-----Тригер вытаскивания госномера при insert и updateпо типу 1234БВ12  ca_objects и пемещение в таблицу object_vehicles

DELIMITER $$
CREATE TRIGGER trg_insert_ca_objects_gos_nomer_4
AFTER INSERT ON ca_objects
FOR EACH ROW
BEGIN
    IF NEW.object_name REGEXP '.*[0-9]{4}[A-Za-zА-Яа-я]{2}[0-9]{2}.*'
        AND NEW.contragent_id IS NOT NULL 
        AND NOT EXISTS (
            SELECT vehicle_gos_nomer FROM object_vehicles
            WHERE UPPER(vehicle_gos_nomer) = UPPER(REGEXP_SUBSTR(NEW.object_name, '[0-9]{4}[A-Za-zА-Яа-я]{2}[0-9]{2}')))
    THEN
        INSERT IGNORE INTO object_vehicles(vehicle_gos_nomer, vehicle_ca_id) 
        VALUES (UPPER(REGEXP_SUBSTR(NEW.object_name, '[0-9]{4}[A-Za-zА-Яа-я]{2}[0-9]{2}')), NEW.contragent_id);
    END IF;
END$$
DELIMITER ;
