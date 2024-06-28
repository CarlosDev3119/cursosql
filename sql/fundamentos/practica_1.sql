


-- Se requiere generar una base de datos que nos permita crear usuarios, roles y permisos con los siguientes campos

-- Requerimentos:
--     - El id de cada tabla tiene que ser una llave primaria, no puede haber nulos a excepcion del estatus de usuario.
--     - El estatus de usuario debera de tener un valor por defecto

usuarios: id de usuario, codigo postal, correo, nombre y un estatus de actividad

roles: id de rol y nombre del rol

permisos: id de permiso y nombre de permiso

-- Insertar un registro en la tabla de usuarios con su nombre, correo y codigo postal
-- insertar 4 registros en la tabla de roles = (admin, user, general, client);
-- insertar 2 registros en la tabla de permisos = (read, write)