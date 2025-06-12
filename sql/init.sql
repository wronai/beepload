-- Create Kratos database and user
CREATE DATABASE kratos;
CREATE USER kratos WITH ENCRYPTED PASSWORD 'kratosSuperSecret';
GRANT ALL PRIVILEGES ON DATABASE kratos TO kratos;

-- Create Config database and user
CREATE DATABASE config;
CREATE USER config WITH ENCRYPTED PASSWORD 'configSecret';
GRANT ALL PRIVILEGES ON DATABASE config TO config;

-- Create main application database and user if not using the default
CREATE USER upload_user WITH ENCRYPTED PASSWORD 'uploadSecret';
GRANT ALL PRIVILEGES ON DATABASE uploaddb TO upload_user;
