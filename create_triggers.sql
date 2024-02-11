
---------------Создание ТРИГГЕРОВ----------------------------
-----Тригер Обновления таблицы sim_cards
DELIMITER //
CREATE TRIGGER log_triger_sim_updates
AFTER UPDATE 
ON sim_cards
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, ) 
    VALUES ()//
DELIMITER ;

-----Тригер удаления в таблице sim_cards
DELIMITER //
CREATE TRIGGER log_triger_sim_deletes
AFTER DELETE 
ON sim_cards
FOR EACH ROW
Insert into log_changes(changes_table, changes_action, obj_key, changes_column, old_val, ) 
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
