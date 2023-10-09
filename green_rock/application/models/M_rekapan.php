<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_rekapan extends CI_Model
{
    public function get_data()
    {
        $this->db->query("SET lc_time_names = 'id_ID'");
        
        return $this->db->query("
            SELECT 
                p.id_penyewa,
                u.nama_lengkap,
                p.nama_barang,
                p.stok,
                CONCAT(p.lama_sewa, ' hari') AS lama_sewa,
                CONCAT(
                    DAYNAME(p.tgl_sewa), ', ', 
                    DATE_FORMAT(p.tgl_sewa, '%d-%m-%Y %H:%i:%s')
                ) AS tgl_sewa,
                CONCAT(
                    DAYNAME(t.tgl_kembali), ', ', 
                    DATE_FORMAT(t.tgl_kembali, '%d-%m-%Y')
                ) AS tgl_kembali,
                CONCAT('Rp. ', FORMAT(t.total_bayar, 0)) AS total_bayar,
                CASE 
                    WHEN p.status = 1 THEN 'Berhasil'
                    WHEN p.status = 2 THEN 'Gagal'
                    ELSE 'Belum di verifikasi'
                END AS status, p.image_path
            FROM 
                t_total t
            JOIN 
                t_penyewaan p ON p.id_penyewa = t.id_penyewa
            JOIN 
                tbl_user u ON u.id_user = p.user_id");
    }

    public function verifikator($id_penyewa){

        $data = array(
            'status' => 1
        );

        $this->db->where('id_penyewa', $id_penyewa);
        $this->db->update('t_penyewaan',$data);


        // return $this->db->query("UPDATE t_penyewaan SET status ='$data' WHERE id_penyewa = '$id_penyewa'");

        // $this->db->where($id_penyewa);
        // $this->db->set('status',$data);
        // $this->db->update('t_penyewaan',[])

    }
    public function verifikasi($id_penyewa){

        $data = array(
            'status' => 2
        );

        $this->db->where('id_penyewa', $id_penyewa);
        $this->db->update('t_penyewaan',$data);


        // return $this->db->query("UPDATE t_penyewaan SET status ='$data' WHERE id_penyewa = '$id_penyewa'");

        // $this->db->where($id_penyewa);
        // $this->db->set('status',$data);
        // $this->db->update('t_penyewaan',[])

    }
}