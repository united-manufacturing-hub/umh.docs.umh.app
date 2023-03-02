---
title: "Migrating DB ordertable"
description: "Ordertable has a unique constraint on asset_id and order_id. This migration changes the constraint to asset_id and order_name."
maximum_version: 0.9.5
---

## Instructions

1. Open OpenLens
2. Open a Shell inside the timescale pod
3. Create a backup of the order table !

    ```sql
    pg_dump --host localhost --port 5432 --username postgres --verbose --file "/var/lib/postgresql/ordertable.sql" --table public.ordertable factoryinsight
    ```
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/pg_dump.png)

4. Execute 

    ```bash
    psql
    ```

5. Select the factoryinsight db

    ```sql
    \c factoryinsight
    ```
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/change_db.png)

6. Check if any old orders would fail under the new constraints

    ```sql
    SELECT order_name, asset_id, count(*) FROM ordertable GROUP BY order_name, asset_id HAVING count(*) > 1;
    ```
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/select_ot.png)

7. If there are any conflicts, remove the conflicting data
    
    ```sql
    DELETE FROM ordertable ox USING (
         SELECT MIN(CTID) as ctid, order_name, asset_id
         FROM ordertable
         GROUP BY order_name, asset_id HAVING count(*) > 1
         ) b
    WHERE ox.order_name = b.order_name AND ox.asset_id = b.asset_id
    AND ox.CTID <> b.ctid;
    ```
    
    If the data can not be removed (e.g. is still required), please make sure to rename the order_names to prevent duplicates !
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/delete_statement.png)

8. Retrieve the name of the old unique constraint
    
    ```sql
    SELECT conname FROM pg_constraint WHERE conrelid = 'ordertable'::regclass AND contype = 'u';
    ```
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/select_pg_constraint.png)

9. Delete the old constraint
    
    ```sql
    ALTER TABLE ordertable DROP CONSTRAINT ordertable_asset_id_order_id_key;
    ```
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/alter_table_drop.png)

10. Create the new constraint
    
    ```sql
    ALTER TABLE ordertable ADD CONSTRAINT ordertable_asset_id_order_name_key UNIQUE (asset_id, order_name);
    ```
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/alter_table_add.png)

11. Exit
    
    ```sql
    exit
    ```
    
    ![Untitled](/images/production-guide/upgrading/migrating-ordertable/exit.png)

12. Close the pod shell. The effect is immediate, you don’t need to restart the container
