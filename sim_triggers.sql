
---------------Создание ТРИГГЕРОВ----------------------------
-----Тригер Обновления таблицы sim_cards
DELIMITER $$
CREATE TRIGGER log_triger_sim_updates
AFTER UPDATE ON sim_cards
FOR EACH ROW
BEGIN
    IF NEW.sim_iccid <> OLD.sim_iccid THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column,
            old_val, 
            new_val
        ) 
            VALUES (
                'sim_cards',
                2,
                OLD.sim_id, 
                'sim_iccid', 
                OLD.sim_iccid, 
                NEW.sim_iccid
            );
    END IF;
    If NEW.sim_tel_number <> OLD.sim_tel_number THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'sim_cards',
                2, 
                OLD.sim_id, 
                'sim_tel_number', 
                OLD.sim_tel_number, 
                NEW.sim_tel_number
            );
    END IF;
    If NEW.status <> OLD.status THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key, 
            changes_column, 
            old_val, 
            new_val
        )
            VALUES (
                'sim_cards',
                2,
                OLD.sim_id,
                'status',
                OLD.status,
                NEW.status
            );
    END IF;
    If NEW.terminal_imei <> OLD.terminal_imei THEN
        Insert into log_changes(
            changes_table, 
            changes_action, 
            obj_key,
            changes_column, 
            old_val,
            new_val
        )
            VALUES (
                'sim_cards',
                2,
                OLD.sim_id, 
                'terminal_imei', 
                OLD.terminal_imei, 
                NEW.terminal_imei
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
                'sim_cards',
                2,
                OLD.sim_id, 
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
                'sim_cards',
                2,
                OLD.sim_id, 
                'itprogrammer_id',
                OLD.itprogrammer_id, 
                NEW.itprogrammer_id
            );
    END IF;
END$$
DELIMITER ;

-----Тригер удаления в таблице sim_cards
DELIMITER //
CREATE TRIGGER log_triger_sim_deletes
AFTER DELETE 
ON sim_cards
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val) 
    VALUES ('sim_cards', 0, OLD.sim_id, 'all', OLD.sim_iccid, 'none')//
DELIMITER ;

-----Тригер добавления в таблице sim_cards
DELIMITER //
CREATE TRIGGER log_triger_sim_inserts
AFTER INSERT 
ON sim_cards
FOR EACH ROW
Insert into 
    log_changes(changes_table, changes_action, obj_key, changes_column, old_val, new_val)
    VALUES ('sim_cards', 1, NEW.sim_id, 'all', 'none', NEW.sim_iccid)//
DELIMITER ;

