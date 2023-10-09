-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 13, 2023 at 05:11 PM
-- Server version: 8.0.32-0ubuntu0.20.04.2
-- PHP Version: 7.4.3-4ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penyewaan`
--

-- --------------------------------------------------------

--
-- Table structure for table `registrasi`
--

CREATE TABLE `registrasi` (
  `id` int NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `nik` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `no_hp` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `t_barang`
--

CREATE TABLE `t_barang` (
  `id` int NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `stok_barang` int NOT NULL,
  `harga_barang` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_barang`
--

INSERT INTO `t_barang` (`id`, `nama_barang`, `stok_barang`, `harga_barang`) VALUES
(1, 'Tenda 2 Orang', 15, 20000),
(2, 'Tenda 3 Orang', 11, 25000),
(10, 'Tenda 5 Orang', 21, 3300);

-- --------------------------------------------------------

--
-- Table structure for table `t_penyewaan`
--

CREATE TABLE `t_penyewaan` (
  `id_penyewa` varchar(255) NOT NULL,
  `id_org` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `lama_sewa` varchar(100) NOT NULL,
  `tgl_sewa` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tgl_kembali` varchar(100) NOT NULL,
  `status` enum('0','1') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_penyewaan`
--

INSERT INTO `t_penyewaan` (`id_penyewa`, `id_org`, `nama_barang`, `lama_sewa`, `tgl_sewa`, `Tgl_kembali`, `status`) VALUES
('0f7b2ffe-d9d4-11ed-8202-4ccc6a2accab', '47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'gagagah', 'bsbsvv', '2023-04-13 08:20:33', 'vvv', '0'),
('28f50c4d-d965-11ed-845f-4ccc6a2accab', '47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'lonte', '24 jam', '2023-04-12 19:06:41', '20-04-2023', '0'),
('40f3af53-d9d8-11ed-8202-4ccc6a2accab', '47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'adgkj', 'afghg', '2023-04-13 08:50:34', 'fhh', '0'),
('b1df195c-d9d3-11ed-8202-4ccc6a2accab', '47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'arsat', '1 hari', '2023-04-13 08:17:56', '14 april 2023', '0'),
('ddb21be6-d9d3-11ed-8202-4ccc6a2accab', '47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'gfdf', 'fcc', '2023-04-13 08:19:09', 'vvv', '0'),
('e91cf849-d9d2-11ed-8202-4ccc6a2accab', '47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'gagagg', 'gagag', '2023-04-13 08:12:19', 'hshhs', '0');

-- --------------------------------------------------------

--
-- Table structure for table `t_user`
--

CREATE TABLE `t_user` (
  `id_user` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `image` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `is_active` int NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_user`
--

INSERT INTO `t_user` (`id_user`, `nama`, `email`, `image`, `password`, `role_id`, `is_active`, `date_created`) VALUES
('47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'arsat mada', 'arsat@gmail.com', 'default.jpg', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2023-04-12 17:27:20'),
('b0a8ab96-d956-11ed-845f-4ccc6a2accab', 'admin', 'admin@gmail.com', 'default.jpg', '12345', 1, 1, '2023-04-12 17:23:07');

-- --------------------------------------------------------

--
-- Table structure for table `user_access_menu`
--

CREATE TABLE `user_access_menu` (
  `id` int NOT NULL,
  `role_id` int NOT NULL,
  `menu_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_access_menu`
--

INSERT INTO `user_access_menu` (`id`, `role_id`, `menu_id`) VALUES
(1, 1, 1),
(7, 1, 3),
(8, 1, 2),
(10, 1, 5),
(13, 1, 6),
(15, 1, 5),
(16, 1, 7),
(17, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_menu`
--

CREATE TABLE `user_menu` (
  `id` int NOT NULL,
  `menu` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_menu`
--

INSERT INTO `user_menu` (`id`, `menu`) VALUES
(1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` int NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`id`, `role`) VALUES
(1, 'Administrator'),
(2, 'MEMBER  1');

-- --------------------------------------------------------

--
-- Table structure for table `user_sub_menu`
--

CREATE TABLE `user_sub_menu` (
  `id` int NOT NULL,
  `menu_id` int NOT NULL,
  `title` varchar(128) NOT NULL,
  `url` varchar(128) NOT NULL,
  `icon` varchar(128) NOT NULL,
  `is_active` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_sub_menu`
--

INSERT INTO `user_sub_menu` (`id`, `menu_id`, `title`, `url`, `icon`, `is_active`) VALUES
(1, 1, 'Dashboard', 'admin', 'fa-boxes-stacked', 1),
(7, 1, 'Role', 'admin/role', 'fa-boxes-stacked', 0),
(15, 1, 'Penyewa', 'penyewa', 'fa-boxes-stacked', 1),
(16, 1, 'Data Barang', 'barang', 'fa-boxes-stacked', 1),
(17, 1, 'Rekapan', 'rekapan', 'adas', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `registrasi`
--
ALTER TABLE `registrasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_barang`
--
ALTER TABLE `t_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_penyewaan`
--
ALTER TABLE `t_penyewaan`
  ADD PRIMARY KEY (`id_penyewa`),
  ADD KEY `id_org` (`id_org`);

--
-- Indexes for table `t_user`
--
ALTER TABLE `t_user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `user_access_menu`
--
ALTER TABLE `user_access_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_menu`
--
ALTER TABLE `user_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `registrasi`
--
ALTER TABLE `registrasi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_barang`
--
ALTER TABLE `t_barang`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_access_menu`
--
ALTER TABLE `user_access_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user_menu`
--
ALTER TABLE `user_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_penyewaan`
--
ALTER TABLE `t_penyewaan`
  ADD CONSTRAINT `t_penyewaan_ibfk_1` FOREIGN KEY (`id_org`) REFERENCES `t_user` (`id_user`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
