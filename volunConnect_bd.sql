CREATE DATABASE IF NOT EXISTS volunconnect;
USE volunconnect;
-- =========================
-- USUARIOS
-- =========================
CREATE TABLE usuarios (
 id_usuario INT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE,
 password VARCHAR(255) NOT NULL,
 rol ENUM('usuario','organizacion','admin') NOT NULL DEFAULT 'usuario',
 fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- =========================
-- ORGANIZACIONES
-- =========================
CREATE TABLE organizaciones (
 id_organizacion INT AUTO_INCREMENT PRIMARY KEY,
 id_usuario INT NOT NULL,
 nombre VARCHAR(150) NOT NULL,
 descripcion TEXT,
 web VARCHAR(255),
 telefono VARCHAR(30),
 FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
 ON DELETE CASCADE
);
-- =========================
-- OFERTAS VOLUNTARIADO
-- =========================
CREATE TABLE ofertas_voluntariado (
 id_oferta INT AUTO_INCREMENT PRIMARY KEY,
 id_organizacion INT NOT NULL,
 titulo VARCHAR(150) NOT NULL,
 descripcion TEXT,
 ubicacion VARCHAR(150),
 fecha_inicio DATE,
 fecha_fin DATE,
 plazas_disponibles INT,
 fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_organizacion) REFERENCES organizaciones(id_organizacion)
 ON DELETE CASCADE
);
-- =========================
-- INSCRIPCIONES
-- =========================
CREATE TABLE inscripciones (
 id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
 id_usuario INT NOT NULL,
 id_oferta INT NOT NULL,
 estado ENUM('pendiente','aceptada','rechazada') DEFAULT 'pendiente',
 fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
 ON DELETE CASCADE,
 FOREIGN KEY (id_oferta) REFERENCES ofertas_voluntariado(id_oferta)
 ON DELETE CASCADE
);
-- =========================
-- COMENTARIOS
-- =========================
CREATE TABLE comentarios (
 id_comentario INT AUTO_INCREMENT PRIMARY KEY,
 id_usuario INT NOT NULL,
 id_oferta INT NOT NULL,
 texto TEXT NOT NULL,
 valoracion INT CHECK (valoracion BETWEEN 1 AND 5),
 fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
 ON DELETE CASCADE,
 FOREIGN KEY (id_oferta) REFERENCES ofertas_voluntariado(id_oferta)
 ON DELETE CASCADE
);
-- =========================
-- LIKES
-- =========================
CREATE TABLE likes (
 id_like INT AUTO_INCREMENT PRIMARY KEY,
 id_usuario INT NOT NULL,
 id_oferta INT NOT NULL,
 fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
 ON DELETE CASCADE,
 FOREIGN KEY (id_oferta) REFERENCES ofertas_voluntariado(id_oferta)
 ON DELETE CASCADE,
 UNIQUE (id_usuario, id_oferta)
);
-- =========================
-- NOTIFICACIONES
-- =========================
CREATE TABLE notificaciones (
 id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
 id_usuario INT NOT NULL,
 mensaje TEXT NOT NULL,
 leida BOOLEAN DEFAULT FALSE,
 fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
 ON DELETE CASCADE
);
-- =========================
-- MENSAJES PRIVADOS
-- =========================
CREATE TABLE mensajes (
 id_mensaje INT AUTO_INCREMENT PRIMARY KEY,
 id_emisor INT NOT NULL,
 id_receptor INT NOT NULL,
 contenido TEXT NOT NULL,
 fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_emisor) REFERENCES usuarios(id_usuario)
 ON DELETE CASCADE,
 FOREIGN KEY (id_receptor) REFERENCES usuarios(id_usuario)
 ON DELETE CASCADE
);