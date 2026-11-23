-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 23-11-2026 a las 16:25:40
-- Versión del servidor: 8.0.43
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lumen`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL,
  `nombre` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_libro` int NOT NULL,
  `fecha` date NOT NULL,
  `cantidad` int NOT NULL,
  `total` float NOT NULL,
  `metodo_pago` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `id_libro` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_categoria` int NOT NULL,
  `autor` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `titulo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `isbn` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `precio` float NOT NULL,
  `formato` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `existencia` int NOT NULL,
  `url_archivo` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `imagen` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`id_libro`, `id_usuario`, `id_categoria`, `autor`, `titulo`, `isbn`, `precio`, `formato`, `existencia`, `url_archivo`, `imagen`) VALUES
(2, 3, 1, 'Gabriel GarcÃ­a MÃ¡rquez', 'El amor en los tiempos del cÃ³lera', '9789579705165', 429.99, 'EPUB', 91, 'https://lumen.example.com/archivos/amor_tiempos.epub', 'amor_tiempos.jpg'),
(3, 1, 1, 'Miguel de Cervantes', 'Don Quijote de la Mancha', '9781006045028', 359.99, 'PDF', 9, 'https://lumen.example.com/archivos/don_quijote.pdf', 'don_quijote.jpg'),
(4, 1, 1, 'Juan Rulfo', 'Pedro PÃ¡ramo', '9786026322975', 199.99, 'EPUB', 82, 'https://lumen.example.com/archivos/pedro_paramo.epub', 'pedro_paramo.jpg'),
(5, 3, 2, 'Octavio Paz', 'El laberinto de la soledad', '9784504559776', 419.99, 'EPUB', 94, 'https://lumen.example.com/archivos/laberinto.epub', 'laberinto.jpg'),
(6, 1, 1, 'Carlos Fuentes', 'La muerte de Artemio Cruz', '9788147632025', 299.99, 'EPUB', 40, 'https://lumen.example.com/archivos/muerte_artemio.epub', 'muerte_artemio.jpg'),
(7, 2, 1, 'Laura Esquivel', 'Como agua para chocolate', '9781669448440', 409.99, 'EPUB', 48, 'https://lumen.example.com/archivos/como_agua_para.epub', 'como_agua_para.jpg'),
(8, 1, 1, 'Jorge Luis Borges', 'Ficciones', '9780995850927', 529.99, 'EPUB', 48, 'https://lumen.example.com/archivos/ficciones.epub', 'ficciones.jpg'),
(9, 2, 1, 'Julio CortÃ¡zar', 'Rayuela', '9786482458881', 129.99, 'FÃ­sico', 113, '', 'rayuela.jpg'),
(10, 2, 1, 'Mario Vargas Llosa', 'La ciudad y los perros', '9785757705293', 459.99, 'MOBI', 98, 'https://lumen.example.com/archivos/ciudad_perros.mobi', 'ciudad_perros.jpg'),
(11, 1, 1, 'Isabel Allende', 'La casa de los espÃ­ritus', '9785927491162', 539.99, 'PDF', 53, 'https://lumen.example.com/archivos/casa_espiritus.pdf', 'casa_espiritus.jpg'),
(12, 2, 1, 'Roberto BolaÃ±o', 'Los detectives salvajes', '9786199271513', 469.99, 'MOBI', 84, 'https://lumen.example.com/archivos/detectives.mobi', 'detectives.jpg'),
(13, 3, 1, 'Mario Benedetti', 'La tregua', '9782447039072', 409.99, 'EPUB', 10, 'https://lumen.example.com/archivos/tregua.epub', 'tregua.jpg'),
(14, 1, 3, 'Pablo Neruda', 'Veinte poemas de amor y una canciÃ³n desesperada', '9789303797565', 539.99, 'MOBI', 114, 'https://lumen.example.com/archivos/veinte_poemas.mobi', 'veinte_poemas.jpg'),
(15, 3, 3, 'Sor Juana InÃ©s de la Cruz', 'Primero sueÃ±o', '9788956192550', 259.99, 'PDF', 63, 'https://lumen.example.com/archivos/primero_sueno.pdf', 'primero_sueno.jpg'),
(16, 1, 2, 'Elena Poniatowska', 'La noche de Tlatelolco', '9787195951133', 159.99, 'MOBI', 50, 'https://lumen.example.com/archivos/noche_tlatelolco.mobi', 'noche_tlatelolco.jpg'),
(17, 3, 1, 'Carlos Ruiz ZafÃ³n', 'La sombra del viento', '9780766678613', 409.99, 'MOBI', 92, 'https://lumen.example.com/archivos/sombra_viento.mobi', 'sombra_viento.jpg'),
(18, 1, 4, 'Federico GarcÃ­a Lorca', 'Bodas de sangre', '9784963481243', 329.99, 'EPUB', 36, 'https://lumen.example.com/archivos/bodas_sangre.epub', 'bodas_sangre.jpg'),
(19, 3, 5, 'George Orwell', '1984', '9785980202385', 209.99, 'FÃ­sico', 86, '', '1984.jpg'),
(20, 1, 5, 'George Orwell', 'RebeliÃ³n en la granja', '9782459384948', 399.99, 'EPUB', 112, 'https://lumen.example.com/archivos/rebelion_granja.epub', 'rebelion_granja.jpg'),
(21, 2, 5, 'Aldous Huxley', 'Un mundo feliz', '9780710694720', 459.99, 'PDF', 56, 'https://lumen.example.com/archivos/mundo_feliz.pdf', 'mundo_feliz.jpg'),
(22, 3, 5, 'Ray Bradbury', 'Fahrenheit 451', '9783378828056', 509.99, 'EPUB', 77, 'https://lumen.example.com/archivos/fahrenheit_451.epub', 'fahrenheit_451.jpg'),
(23, 3, 5, 'Isaac Asimov', 'FundaciÃ³n', '9784926884265', 389.99, 'EPUB', 55, 'https://lumen.example.com/archivos/fundacion.epub', 'fundacion.jpg'),
(24, 3, 5, 'Frank Herbert', 'Dune', '9786027644465', 209.99, 'EPUB', 36, 'https://lumen.example.com/archivos/dune.epub', 'dune.jpg'),
(25, 3, 6, 'J. R. R. Tolkien', 'El seÃ±or de los anillos', '9784288530299', 429.99, 'MOBI', 59, 'https://lumen.example.com/archivos/senor_anillos.mobi', 'senor_anillos.jpg'),
(26, 3, 6, 'J. R. R. Tolkien', 'El hobbit', '9785299085990', 189.99, 'MOBI', 22, 'https://lumen.example.com/archivos/hobbit.mobi', 'hobbit.jpg'),
(27, 1, 6, 'J. K. Rowling', 'Harry Potter y la piedra filosofal', '9781641121194', 439.99, 'PDF', 115, 'https://lumen.example.com/archivos/harry_potter.pdf', 'harry_potter.jpg'),
(28, 3, 6, 'Suzanne Collins', 'Los juegos del hambre', '9780682123563', 449.99, 'EPUB', 59, 'https://lumen.example.com/archivos/juegos_hambre.epub', 'juegos_hambre.jpg'),
(29, 3, 6, 'Antoine de Saint-ExupÃ©ry', 'El principito', '9782699538514', 259.99, 'FÃ­sico', 64, '', 'principito.jpg'),
(30, 3, 6, 'Lewis Carroll', 'Alicia en el paÃ­s de las maravillas', '9789500343671', 399.99, 'PDF', 19, 'https://lumen.example.com/archivos/alicia_pais.pdf', 'alicia_pais.jpg'),
(31, 1, 1, 'Jane Austen', 'Orgullo y prejuicio', '9783151433620', 439.99, 'MOBI', 48, 'https://lumen.example.com/archivos/orgullo.mobi', 'orgullo.jpg'),
(32, 3, 1, 'Emily BrontÃ«', 'Cumbres borrascosas', '9789404399316', 159.99, 'FÃ­sico', 5, '', 'cumbres.jpg'),
(33, 1, 1, 'Charlotte BrontÃ«', 'Jane Eyre', '9785451190470', 539.99, 'MOBI', 102, 'https://lumen.example.com/archivos/jane_eyre.mobi', 'jane_eyre.jpg'),
(34, 3, 5, 'Mary Shelley', 'Frankenstein', '9785450988696', 489.99, 'PDF', 43, 'https://lumen.example.com/archivos/frankenstein.pdf', 'frankenstein.jpg'),
(35, 1, 5, 'Bram Stoker', 'DrÃ¡cula', '9785791538161', 159.99, 'EPUB', 102, 'https://lumen.example.com/archivos/dracula.epub', 'dracula.jpg'),
(36, 1, 1, 'Oscar Wilde', 'El retrato de Dorian Gray', '9781201170549', 359.99, 'PDF', 67, 'https://lumen.example.com/archivos/retrato_dorian.pdf', 'retrato_dorian.jpg'),
(37, 2, 1, 'FiÃ³dor Dostoyevski', 'Crimen y castigo', '9782571099652', 489.99, 'MOBI', 111, 'https://lumen.example.com/archivos/crimen_castigo.mobi', 'crimen_castigo.jpg'),
(38, 1, 1, 'FiÃ³dor Dostoyevski', 'Los hermanos KaramÃ¡zov', '9780919696907', 199.99, 'PDF', 77, 'https://lumen.example.com/archivos/hermanos.pdf', 'hermanos.jpg'),
(39, 3, 1, 'LeÃ³n TolstÃ³i', 'Guerra y paz', '9788223084618', 459.99, 'FÃ­sico', 102, '', 'guerra_paz.jpg'),
(40, 3, 1, 'LeÃ³n TolstÃ³i', 'Ana KarÃ©nina', '9781773037226', 149.99, 'EPUB', 65, 'https://lumen.example.com/archivos/ana_karenina.epub', 'ana_karenina.jpg'),
(41, 2, 1, 'Victor Hugo', 'Los miserables', '9782274165845', 329.99, 'MOBI', 82, 'https://lumen.example.com/archivos/miserables.mobi', 'miserables.jpg'),
(42, 3, 1, 'Alexandre Dumas', 'El conde de Montecristo', '9786978012511', 419.99, 'EPUB', 56, 'https://lumen.example.com/archivos/conde.epub', 'conde.jpg'),
(43, 2, 1, 'Franz Kafka', 'La metamorfosis', '9781299272699', 289.99, 'MOBI', 71, 'https://lumen.example.com/archivos/metamorfosis.mobi', 'metamorfosis.jpg'),
(44, 1, 1, 'Albert Camus', 'El extranjero', '9786316916723', 189.99, 'EPUB', 48, 'https://lumen.example.com/archivos/extranjero.epub', 'extranjero.jpg'),
(45, 1, 1, 'Ernest Hemingway', 'El viejo y el mar', '9787600384273', 359.99, 'EPUB', 5, 'https://lumen.example.com/archivos/viejo_mar.epub', 'viejo_mar.jpg'),
(46, 1, 1, 'F. Scott Fitzgerald', 'El gran Gatsby', '9789230264802', 189.99, 'PDF', 120, 'https://lumen.example.com/archivos/gran_gatsby.pdf', 'gran_gatsby.jpg'),
(47, 2, 1, 'Harper Lee', 'Matar a un ruiseÃ±or', '9787183094170', 119.99, 'MOBI', 35, 'https://lumen.example.com/archivos/matar_ruisenor.mobi', 'matar_ruisenor.jpg'),
(48, 3, 1, 'J. D. Salinger', 'El guardiÃ¡n entre el centeno', '9789474516088', 189.99, 'FÃ­sico', 21, '', 'guardian_entre.jpg'),
(49, 2, 1, 'Herman Melville', 'Moby Dick', '9782044510950', 199.99, 'FÃ­sico', 65, '', 'moby_dick.jpg'),
(50, 2, 6, 'Mark Twain', 'Las aventuras de Tom Sawyer', '9784548140848', 129.99, 'PDF', 60, 'https://lumen.example.com/archivos/aventuras_tom.pdf', 'aventuras_tom.jpg'),
(51, 1, 1, 'Umberto Eco', 'El nombre de la rosa', '9787230196727', 299.99, 'FÃ­sico', 98, '', 'nombre_rosa.jpg'),
(52, 2, 4, 'Agatha Christie', 'Asesinato en el Orient Express', '9788596296601', 119.99, 'PDF', 98, 'https://lumen.example.com/archivos/asesinato_orient.pdf', 'asesinato_orient.jpg'),
(53, 3, 4, 'Arthur Conan Doyle', 'Estudio en escarlata', '9784816951350', 199.99, 'PDF', 29, 'https://lumen.example.com/archivos/estudio.pdf', 'estudio.jpg'),
(54, 2, 2, 'Yuval Noah Harari', 'Sapiens: de animales a dioses', '9782682276317', 279.99, 'EPUB', 40, 'https://lumen.example.com/archivos/sapiens_animales.epub', 'sapiens_animales.jpg'),
(55, 3, 2, 'Stephen Hawking', 'Breve historia del tiempo', '9781051286971', 289.99, 'PDF', 115, 'https://lumen.example.com/archivos/breve_historia.pdf', 'breve_historia.jpg'),
(56, 1, 2, 'Dale Carnegie', 'CÃ³mo ganar amigos e influir sobre las personas', '9781001401416', 389.99, 'PDF', 74, 'https://lumen.example.com/archivos/como_ganar.pdf', 'como_ganar.jpg'),
(57, 2, 1, 'Paulo Coelho', 'El alquimista', '9782295094087', 169.99, 'EPUB', 67, 'https://lumen.example.com/archivos/alquimista.epub', 'alquimista.jpg'),
(58, 2, 4, 'Stieg Larsson', 'Los hombres que no amaban a las mujeres', '9780023143137', 499.99, 'FÃ­sico', 26, '', 'hombres_no.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pertenece`
--

CREATE TABLE `pertenece` (
  `id_pertenece` int NOT NULL,
  `id_categoria` int NOT NULL,
  `id_libro` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publica`
--

CREATE TABLE `publica` (
  `id_usuario` int NOT NULL,
  `id_libro` int NOT NULL,
  `fecha_publicacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reseña`
--

CREATE TABLE `reseña` (
  `id_usuario` int NOT NULL,
  `id_libro` int NOT NULL,
  `calificacion` float NOT NULL,
  `comentario` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `clave` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `perfil` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `correo`, `clave`, `perfil`) VALUES
(1, 'val', 'vale@gmail.com', 'scrypt:32768:8:1$c9KCP6mNFEcja76Y$adab4a789aadf62f28296e15379af40e260d5e2477e3b3b69970fc3fef36a4e09242bb5b876819600fa173b0d0817c5edcfa2736f4d8c7a81fc0d301cdff1a51', 'A'),
(2, 'leo', 'leo@gmail.com', 'scrypt:32768:8:1$5fovWZ4VWndGhjUq$9bba4ac3a67e35ebc7da38bbe94d11ddc4f003f17fb7fc3f45a0a54097ff83a0524b58ba9c6c09977ca1dcf3ce28a55053f0a1f945bf2bbac3c678160d2d3dfd', 'U');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`id_libro`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `pertenece`
--
ALTER TABLE `pertenece`
  ADD PRIMARY KEY (`id_pertenece`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `publica`
--
ALTER TABLE `publica`
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `reseña`
--
ALTER TABLE `reseña`
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `id_compra` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `libro`
--
ALTER TABLE `libro`
  MODIFY `id_libro` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `pertenece`
--
ALTER TABLE `pertenece`
  MODIFY `id_pertenece` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
