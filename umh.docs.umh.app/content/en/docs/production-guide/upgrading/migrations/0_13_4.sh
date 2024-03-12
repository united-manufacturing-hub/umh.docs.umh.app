#!/usr/bin/env bash

# Variables for your Kubernetes and PostgreSQL setup
POD_NAME="united-manufacturing-hub-timescaledb-0"
CONTAINER_NAME="timescaledb"
KUBECONFIG_PATH="/etc/rancher/k3s/k3s.yaml"
NAMESPACE="united-manufacturing-hub"
PG_USER="postgres"
DATABASE_NAME="umh_v2"
DATABASE_OWNER="kafkatopostgresqlv2"
GRAFANA_USER="grafanareader"

# Remove old log if present (log output of this to /dev/null)
rm -f /tmp/upgrade_0_13_4.log 2>/dev/null
# Log output of all other sudo commands to /tmp/upgrade_0_13_4.log

echo "=========================================================="
echo "Starting migration to 0.13.4, this will take a few minutes"
echo "=========================================================="
echo ""
# Ensure repo is added
echo "Ensuring helm repo is added"
if ! sudo $(which helm) repo add united-manufacturing-hub https://management.umh.app/helm/umh >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to add helm repo"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi


# Update repo
echo "Updating helm repo"
if ! sudo $(which helm) repo update --kubeconfig /etc/rancher/k3s/k3s.yaml >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to update helm repo"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Helm repo updated"


# Update chart
echo "Upgrading united-manufacturing-hub to 0.13.4"
if ! sudo $(which helm) upgrade united-manufacturing-hub united-manufacturing-hub/united-manufacturing-hub -n united-manufacturing-hub --version 0.13.4 --reuse-values --kubeconfig /etc/rancher/k3s/k3s.yaml --set mqtt_broker.initContainer.hivemqextensioninit.image.tag=0.11.0 >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to upgrade united-manufacturing-hub to 0.13.4"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ United-manufacturing-hub upgraded to 0.13.4"


## Create kafkatopostgresqlv2 user if it doesn't exist
echo "Creating $DATABASE_OWNER user if it doesn't exist"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -c "DO \$\$ BEGIN IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = '$DATABASE_OWNER') THEN CREATE USER $DATABASE_OWNER; END IF; END\$\$;" >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to create $DATABASE_OWNER user"

    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ $DATABASE_OWNER user created"

## Create umh_v2 database if it doesn't exist
echo "Creating $DATABASE_NAME database if it doesn't exist"
DB_EXISTS=$(sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -tAc "SELECT 1 FROM pg_database WHERE datname='$DATABASE_NAME'" | tr -d '[:space:]')
# If the database doesn't exist, create it
if [ "$DB_EXISTS" != "1" ]; then
    if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -c "CREATE DATABASE $DATABASE_NAME OWNER $DATABASE_OWNER;" >> /tmp/upgrade_0_13_4.log 2>&1
    then
        echo "Failed to create $DATABASE_NAME database"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
    fi
    echo "Database $DATABASE_NAME created."
else
    echo "Database $DATABASE_NAME already exists."
fi
echo "✅ $DATABASE_NAME database created"

# Grant privileges to kafkatopostgresqlv2 user
echo "Granting privileges to $DATABASE_OWNER user on $DATABASE_NAME database"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -c "GRANT ALL PRIVILEGES ON DATABASE umh_v2 TO $DATABASE_OWNER;" >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to grant privileges to $DATABASE_OWNER user"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Privileges granted to $DATABASE_OWNER user on $DATABASE_NAME database"

# Create grafanareader user if it doesn't exist
echo "Creating $GRAFANA_USER user if it doesn't exist"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -c "DO \$\$ BEGIN IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = '$GRAFANA_USER') THEN CREATE USER $GRAFANA_USER; END IF; END\$\$;" >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to create $GRAFANA_USER user"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -c "GRANT USAGE ON SCHEMA public TO $GRAFANA_USER;" >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to grant privileges to $GRAFANA_USER user"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ $GRAFANA_USER user created"

# Grant more privileges to kafkatopostgresqlv2 user
echo "Granting privileges to $DATABASE_OWNER user on $DATABASE_NAME tables & sequences"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DATABASE_OWNER;" >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to grant privileges to $DATABASE_OWNER user"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi

if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DATABASE_OWNER;" >> /tmp/upgrade_0_13_4.log 2>&1
then
    echo "Failed to grant privileges to $DATABASE_OWNER user"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Privileges granted to $DATABASE_OWNER user on $DATABASE_NAME tables & sequences"

# Create tables
echo "Creating asset table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  CREATE TABLE IF NOT EXISTS asset (
  id SERIAL PRIMARY KEY,
  enterprise TEXT NOT NULL,
  site TEXT DEFAULT '' NOT NULL,
  area TEXT DEFAULT '' NOT NULL,
  line TEXT DEFAULT '' NOT NULL,
  workcell TEXT DEFAULT '' NOT NULL,
  origin_id TEXT DEFAULT '' NOT NULL,
  UNIQUE (enterprise, site, area, line, workcell, origin_id)
  );
  -- These are just to drop for old installs.
  ALTER TABLE asset DROP CONSTRAINT IF EXISTS asset_enterprise_key;
  ALTER TABLE asset DROP CONSTRAINT IF EXISTS asset_enterprise_site_key;
  ALTER TABLE asset DROP CONSTRAINT IF EXISTS asset_enterprise_site_area_key;
  ALTER TABLE asset DROP CONSTRAINT IF EXISTS asset_enterprise_site_area_line_key;
  ALTER TABLE asset DROP CONSTRAINT IF EXISTS asset_enterprise_site_area_line_workcell_key;
EOF
then
    echo "Failed to create asset table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Asset table created"

echo "Creating tag table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  CREATE TABLE IF NOT EXISTS tag (
  timestamp TIMESTAMPTZ NOT NULL,
  name TEXT NOT NULL,
  origin TEXT NOT NULL,
  asset_id INT REFERENCES asset(id) NOT NULL,
  value REAL,
  UNIQUE (name, asset_id, timestamp)
  );
  SELECT create_hypertable('tag', 'timestamp', if_not_exists => TRUE);;
  CREATE INDEX IF NOT EXISTS ON tag (asset_id, timestamp DESC);
  CREATE INDEX IF NOT EXISTS ON tag (name);
EOF
then
    echo "Failed to create tag table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Tag table created"

echo "Creating tag_string table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  CREATE TABLE IF NOT EXISTS tag_string (
  timestamp TIMESTAMPTZ NOT NULL,
  name TEXT NOT NULL,
  origin TEXT NOT NULL,
  asset_id INT REFERENCES asset(id) NOT NULL,
  value TEXT,
  UNIQUE (name, asset_id, timestamp)
  );
  SELECT create_hypertable('tag_string', 'timestamp', if_not_exists => TRUE);;
  CREATE INDEX IF NOT EXISTS ON tag_string (asset_id, timestamp DESC);
  CREATE INDEX IF NOT EXISTS ON tag_string (name);
EOF
then
    echo "Failed to create tag_string table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Tag_string table created"

echo "Creating get_asset_id function"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  CREATE OR REPLACE FUNCTION get_asset_id(
  _enterprise text,
  _site text DEFAULT '',
  _area text DEFAULT '',
  _line text DEFAULT '',
  _workcell text DEFAULT '',
  _origin_id text DEFAULT ''
  )
  RETURNS integer AS '
  DECLARE
  result_id integer;
  BEGIN
  SELECT id INTO result_id FROM asset
  WHERE enterprise = _enterprise
  AND site = _site
  AND area = _area
  AND line = _line
  AND workcell = _workcell
  AND origin_id = _origin_id
  LIMIT 1; -- Ensure only one id is returned
  RETURN result_id;
  END;
  ' LANGUAGE plpgsql;
  GRANT EXECUTE ON FUNCTION umh_v2.public.get_asset_id(text, text, text, text, text, text) TO $GRAFANA_USER;
  -- $$
  CREATE OR REPLACE FUNCTION get_asset_ids(
  _enterprise text,
  _site text DEFAULT '',
  _area text DEFAULT '',
  _line text DEFAULT '',
  _workcell text DEFAULT '',
  _origin_id text DEFAULT ''
  )
  RETURNS SETOF integer AS '
  BEGIN
  RETURN QUERY
  SELECT id FROM asset
  WHERE enterprise = _enterprise
  AND (_site = '''' OR site = _site)
  AND (_area = '''' OR area = _area)
  AND (_line = '''' OR line = _line)
  AND (_workcell = '''' OR workcell = _workcell)
  AND (_origin_id = '''' OR origin_id = _origin_id);
  END;
  ' LANGUAGE plpgsql;
  GRANT EXECUTE ON FUNCTION umh_v2.public.get_asset_ids(text, text, text, text, text, text) TO $GRAFANA_USER;
EOF
then
    echo "Failed to create get_asset_id function"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ get_asset_id function created"

echo "Creating product_type table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  CREATE TABLE IF NOT EXISTS product_type (
  product_type_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  external_product_type_id TEXT NOT NULL,
  cycle_time_ms INTEGER NOT NULL,
  asset_id INTEGER REFERENCES asset(id),
  CONSTRAINT external_product_asset_uniq UNIQUE (external_product_type_id, asset_id),
  CHECK (cycle_time_ms > 0)
  );
EOF
then
    echo "Failed to create product_type table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Product_type table created"

echo "Creating work_order table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
CREATE EXTENSION IF NOT EXISTS btree_gist;
  -- This table stores information about manufacturing orders. The ISA-95 model defines work orders in terms of production requests.
  -- Here, each work order is linked to a specific asset and product type
  CREATE TABLE IF NOT EXISTS work_order (
  work_order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  external_work_order_id TEXT NOT NULL,
  asset_id INTEGER NOT NULL REFERENCES asset(id),
  product_type_id INTEGER NOT NULL REFERENCES product_type(product_type_id),
  quantity INTEGER NOT NULL,
  status INTEGER NOT NULL DEFAULT 0, -- 0: planned, 1: in progress, 2: completed
  start_time TIMESTAMPTZ,
  end_time TIMESTAMPTZ,
  CONSTRAINT asset_workorder_uniq UNIQUE (asset_id, external_work_order_id),
  CHECK (quantity > 0),
  CHECK (status BETWEEN 0 AND 2),
  UNIQUE (asset_id, start_time),
  EXCLUDE USING gist (asset_id WITH =, tstzrange(start_time, end_time) WITH &&) WHERE (start_time IS NOT NULL AND end_time IS NOT NULL)
  );
EOF
then
    echo "Failed to create work_order table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Work_order table created"

echo "Creating product table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  CREATE TABLE IF NOT EXISTS product (
  product_type_id INTEGER REFERENCES product_type(product_type_id),
  product_batch_id TEXT,
  asset_id INTEGER REFERENCES asset(id),
  start_time TIMESTAMPTZ,
  end_time TIMESTAMPTZ NOT NULL,
  quantity INTEGER NOT NULL,
  bad_quantity INTEGER DEFAULT 0,
  CHECK (quantity > 0),
  CHECK (bad_quantity >= 0),
  CHECK (bad_quantity <= quantity),
  CHECK (start_time <= end_time),
  UNIQUE (asset_id, end_time, product_batch_id)
  );
  -- creating hypertable
  SELECT create_hypertable('product', 'end_time', if_not_exists => TRUE);;
  -- creating an index to increase performance
  CREATE INDEX IF NOT EXISTS idx_products_asset_end_time ON product(asset_id, end_time DESC);
EOF
then
    echo "Failed to create product table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Product table created"

echo "Creating shift table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  -- Manages work shifts for assets. Shift scheduling is a key operational aspect under ISA-95, impacting resource planning and allocation.
  CREATE TABLE IF NOT EXISTS shift (
  shift_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  asset_id INTEGER REFERENCES asset(id),
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  CONSTRAINT shift_start_asset_uniq UNIQUE (start_time, asset_id),
  CHECK (start_time < end_time),
  EXCLUDE USING gist (asset_id WITH =, tstzrange(start_time, end_time) WITH &&)
  );
EOF
then
    echo "Failed to create shift table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Shift table created"

echo "Creating state table"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  -- Records the state changes of assets over time. State tracking supports ISA-95's goal of detailed monitoring and control of manufacturing operations.
  -- State Table
  -- It assumes that a state continues until a new state is recorded.
  CREATE TABLE IF NOT EXISTS state (
  asset_id INTEGER REFERENCES asset(id),
  start_time TIMESTAMPTZ NOT NULL,
  state INT NOT NULL,
  CHECK (state >= 0),
  UNIQUE (start_time, asset_id)
  );
  -- creating hypertable
  SELECT create_hypertable('state', 'start_time', if_not_exists => TRUE);;
  -- creating an index to increase performance
  CREATE INDEX IF NOT EXISTS idx_states_asset_start_time ON state(asset_id, start_time DESC);
EOF
then
    echo "Failed to create state table"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ State table created"

echo "Setting owner and permissions for tables in $DATABASE_NAME database"
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  ALTER TABLE asset OWNER TO $DATABASE_OWNER;
  ALTER TABLE tag OWNER TO $DATABASE_OWNER;
  ALTER TABLE tag_string OWNER TO $DATABASE_OWNER;
  ALTER TABLE work_order OWNER TO $DATABASE_OWNER;
  ALTER TABLE product_type OWNER TO $DATABASE_OWNER;
  ALTER TABLE product OWNER TO $DATABASE_OWNER;
  ALTER TABLE shift OWNER TO $DATABASE_OWNER;
  ALTER TABLE state OWNER TO $DATABASE_OWNER;

  GRANT SELECT ON umh_v2.public.asset TO $GRAFANA_USER;
  GRANT SELECT ON umh_v2.public.tag TO $GRAFANA_USER;
  GRANT SELECT ON umh_v2.public.tag_string TO $GRAFANA_USER;
  GRANT SELECT ON umh_v2.public.work_order TO $GRAFANA_USER;
  GRANT SELECT ON umh_v2.public.product_type TO $GRAFANA_USER;
  GRANT SELECT ON umh_v2.public.product TO $GRAFANA_USER;
  GRANT SELECT ON umh_v2.public.shift TO $GRAFANA_USER;
  GRANT SELECT ON umh_v2.public.state TO $GRAFANA_USER;
EOF
then
    echo "Failed to set owner and permissions for tables in $DATABASE_NAME database"
    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Owner and permissions set for tables in $DATABASE_NAME database"

echo "Setting password for $DATABASE_OWNER & $GRAFANA_USER users"
# Set password for kafkatopostgresqlv2 user
if ! sudo $(which kubectl) exec -it $POD_NAME -c $CONTAINER_NAME --kubeconfig $KUBECONFIG_PATH -n $NAMESPACE -- psql -U $PG_USER -d umh_v2 <<EOF >> /tmp/upgrade_0_13_4.log 2>&1
  ALTER USER $DATABASE_OWNER WITH PASSWORD 'changemetoo';
  ALTER USER $GRAFANA_USER WITH PASSWORD 'changeme';
EOF
then
    echo "Failed to set password for $DATABASE_OWNER & $GRAFANA_USER users"

    echo "See /tmp/upgrade_0_13_4.log for more details"
    exit 1
fi
echo "✅ Password set for $DATABASE_OWNER & $GRAFANA_USER users using default passwords"
echo "$DATABASE_OWNER: changemetoo"
echo "$GRAFANA_USER: changeme"

echo ""
echo "Extended upgrade logs can be found at /tmp/upgrade_0_13_4.log"

echo ""
echo "=========================================================="
echo "        Migration to 0.13.4 completed successfully"
echo "=========================================================="