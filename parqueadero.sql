-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-02-2020 a las 20:11:33
-- Versión del servidor: 10.1.39-MariaDB
-- Versión de PHP: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `parqueaderoapp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `idEmpresa` int(6) NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `latitud` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `longitud` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `num_espacios` int(50) NOT NULL,
  `fraccion` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `precio` double NOT NULL,
  `descuento` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`idEmpresa`, `nombre`, `direccion`, `latitud`, `longitud`, `num_espacios`, `fraccion`, `precio`, `descuento`) VALUES
(1, 'Parking Mercadillo', 'Mercadillo', '-4.017184', '-79.202588', 20, 'Por hora', 0.5, 2.5),
(2, 'ParkeaT', 'Sucre', '-4.008707', '-79.202331', 12, 'Por cuarto de hora', 0.25, 3.5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacios`
--

CREATE TABLE `espacios` (
  `idEspacio` int(10) NOT NULL,
  `id_Empresa` int(10) NOT NULL,
  `estado` int(11) NOT NULL,
  `cubierto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `idPago` int(10) NOT NULL,
  `valor` double NOT NULL,
  `id_Empresa` int(10) NOT NULL,
  `id_Tarjeta` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `idReserva` int(10) NOT NULL,
  `id_Empresa` int(10) NOT NULL,
  `id_Tarjeta` int(10) NOT NULL,
  `horaInicio` date NOT NULL,
  `horaSalida` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_adicionales`
--

CREATE TABLE `servicios_adicionales` (
  `idServicioA` int(10) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `precio` double NOT NULL,
  `cantidad` int(10) NOT NULL,
  `descuento` double DEFAULT NULL,
  `id_Empresa` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjeta`
--

CREATE TABLE `tarjeta` (
  `idTarjeta` int(10) NOT NULL,
  `saldo` double NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(10) NOT NULL,
  `ip` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_Tarjeta` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`idEmpresa`);

--
-- Indices de la tabla `espacios`
--
ALTER TABLE `espacios`
  ADD PRIMARY KEY (`idEspacio`),
  ADD KEY `espacios_ibfk_1` (`id_Empresa`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`idPago`),
  ADD KEY `pago_ibfk_1` (`id_Empresa`),
  ADD KEY `pago_ibfk_2` (`id_Tarjeta`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`idReserva`) USING BTREE,
  ADD KEY `reserva_ibfk_1` (`id_Tarjeta`),
  ADD KEY `reserva_ibfk_2` (`id_Empresa`);

--
-- Indices de la tabla `servicios_adicionales`
--
ALTER TABLE `servicios_adicionales`
  ADD PRIMARY KEY (`idServicioA`),
  ADD KEY `servicios_adicionales_ibfk_1` (`id_Empresa`);

--
-- Indices de la tabla `tarjeta`
--
ALTER TABLE `tarjeta`
  ADD PRIMARY KEY (`idTarjeta`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `idTarjeta` (`id_Tarjeta`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `espacios`
--
ALTER TABLE `espacios`
  ADD CONSTRAINT `espacios_ibfk_1` FOREIGN KEY (`id_Empresa`) REFERENCES `empresa` (`idEmpresa`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_Empresa`) REFERENCES `empresa` (`idEmpresa`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pago_ibfk_2` FOREIGN KEY (`id_Tarjeta`) REFERENCES `tarjeta` (`idTarjeta`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`id_Tarjeta`) REFERENCES `tarjeta` (`idTarjeta`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`id_Empresa`) REFERENCES `empresa` (`idEmpresa`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `servicios_adicionales`
--
ALTER TABLE `servicios_adicionales`
  ADD CONSTRAINT `servicios_adicionales_ibfk_1` FOREIGN KEY (`id_Empresa`) REFERENCES `empresa` (`idEmpresa`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_Tarjeta`) REFERENCES `tarjeta` (`idTarjeta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
