-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: database:3306
-- Generation Time: Oct 09, 2023 at 03:17 AM
-- Server version: 8.0.33
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Table structure for table `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_role`
--

CREATE TABLE `tbl_role` (
  `id_role` int NOT NULL,
  `role` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_role`
--

INSERT INTO `tbl_role` (`id_role`, `role`) VALUES
(1, 'admin'),
(2, 'member');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_user` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `no_hp` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nik` varchar(255) NOT NULL,
  `date_created` timestamp NULL DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_barang`
--

CREATE TABLE `t_barang` (
  `id` int NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `stok_barang` int NOT NULL,
  `harga_barang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_barang`
--

INSERT INTO `t_barang` (`id`, `nama_barang`, `stok_barang`, `harga_barang`) VALUES
(1, 'Tenda 2 Orang', 11, 20000),
(2, 'Tenda 3 Orang', 11, 30000),
(12, 'Tenda 4 Orang', 12, 40000),
(13, 'Tenda 5 Orang', 15, 15000),
(14, 'Gas Portable', 20, 10000),
(15, 'Alat Masak', 10, 15000),
(16, 'Kompor Kotak', 15, 10000),
(17, 'Kompor Windroof', 10, 15000),
(18, 'Headlam', 5, 5000),
(19, 'Carriel 65L', 5, 25000),
(20, 'Matras Camping', 7, 8000),
(21, 'Hammock Single', 20, 5000);

-- --------------------------------------------------------

--
-- Table structure for table `t_penyewaan`
--

CREATE TABLE `t_penyewaan` (
  `id_penyewa` varchar(255) NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `stok` int NOT NULL,
  `lama_sewa` int DEFAULT NULL,
  `tgl_sewa` datetime(6) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `total` int DEFAULT NULL,
  `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Triggers `t_penyewaan`
--
DELIMITER $$
CREATE TRIGGER `after_penyewa_insert` AFTER INSERT ON `t_penyewaan` FOR EACH ROW BEGIN
    DECLARE harga INT;
    DECLARE total_lama_sewa INT;
    DECLARE total_stok INT;
    DECLARE total_bayar INT;
    DECLARE tgl_kembali VARCHAR(10);

    -- Mengambil harga barang berdasarkan id_barang yang diinsert ke tabel penyewaan
    SELECT harga_barang INTO harga FROM t_barang WHERE nama_barang = NEW.nama_barang;

    -- Menghitung total bayar berdasarkan harga default dan lama_sewa
    SET total_lama_sewa = harga * NEW.lama_sewa;
    

    -- Menghitung total bayar berdasarkan harga default dan stok
    SET total_stok = harga * NEW.stok;
    -- Menjumlahkan total bayar berdasarkan lama_sewa dan stok
    SET total_bayar = total_lama_sewa + total_stok;

UPDATE t_barang
    SET stok_barang = stok_barang - NEW.stok
    WHERE nama_barang = NEW.nama_barang;
    -- Menghitung tanggal kembali berdasarkan tanggal sewa dan lama_sewa
    SET tgl_kembali = DATE_FORMAT(DATE_ADD(NEW.tgl_sewa, INTERVAL NEW.lama_sewa DAY), '%Y-%m-%d');

    -- Mengecek apakah sudah ada data untuk id_penyewa di tabel t_total
    IF EXISTS (SELECT 1 FROM t_total WHERE id_penyewa = NEW.id_penyewa) THEN
        -- Jika sudah ada, update nilai total_bayar dengan penambahan harga baru
        UPDATE t_total SET total_bayar = total_bayar + total_bayar WHERE id_penyewa = NEW.id_penyewa;
    ELSE
        -- Jika belum ada, buat data baru di tabel t_total
        INSERT INTO t_total (id_penyewa, total_bayar, tgl_kembali)
        VALUES (NEW.id_penyewa, total_bayar, tgl_kembali);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `t_total`
--

CREATE TABLE `t_total` (
  `id_total` int NOT NULL,
  `id_penyewa` varchar(255) NOT NULL,
  `total_bayar` int NOT NULL,
  `tgl_kembali` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_user`
--

INSERT INTO `t_user` (`id_user`, `nama`, `email`, `image`, `password`, `role_id`, `is_active`, `date_created`) VALUES
('47cfb1b5-d957-11ed-845f-4ccc6a2accab', 'arsat mada', 'arsat@gmail.com', 'default.jpg', '202cb962ac59075b964b07152d234b70', 2, 1, '2023-04-12 17:27:20'),
('b0a8ab96-d956-11ed-845f-4ccc6a2accab', 'admin', 'admin@gmail.com', 'default.jpg', '827ccb0eea8a706c4c34a16891f84e7b', 1, 1, '2023-04-12 17:23:07');

-- --------------------------------------------------------

--
-- Table structure for table `user_access_menu`
--

CREATE TABLE `user_access_menu` (
  `id` int NOT NULL,
  `role_id` int NOT NULL,
  `menu_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
-- Indexes for table `tbl_role`
--
ALTER TABLE `tbl_role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `t_barang`
--
ALTER TABLE `t_barang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama_barang` (`nama_barang`);

--
-- Indexes for table `t_penyewaan`
--
ALTER TABLE `t_penyewaan`
  ADD PRIMARY KEY (`id_penyewa`),
  ADD KEY `id_org` (`user_id`),
  ADD KEY `nama_barang` (`nama_barang`),
  ADD KEY `nama_barang_2` (`nama_barang`);

--
-- Indexes for table `t_total`
--
ALTER TABLE `t_total`
  ADD PRIMARY KEY (`id_total`),
  ADD KEY `id_penyewa` (`id_penyewa`);

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
-- AUTO_INCREMENT for table `tbl_role`
--
ALTER TABLE `tbl_role`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `t_barang`
--
ALTER TABLE `t_barang`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `t_total`
--
ALTER TABLE `t_total`
  MODIFY `id_total` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

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
-- Constraints for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `tbl_user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `tbl_role` (`id_role`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `t_penyewaan`
--
ALTER TABLE `t_penyewaan`
  ADD CONSTRAINT `t_penyewaan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id_user`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_penyewaan_ibfk_2` FOREIGN KEY (`nama_barang`) REFERENCES `t_barang` (`nama_barang`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `t_total`
--
ALTER TABLE `t_total`
  ADD CONSTRAINT `t_total_ibfk_1` FOREIGN KEY (`id_penyewa`) REFERENCES `t_penyewaan` (`id_penyewa`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
